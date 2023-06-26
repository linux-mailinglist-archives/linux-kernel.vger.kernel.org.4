Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BC073D8AC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 09:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjFZHju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 03:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjFZHjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 03:39:48 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCB91AC;
        Mon, 26 Jun 2023 00:39:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1687765178; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=qwiiciZ8V1OOz8uzIc80dYdpDQz6tLDfTRJu1yMtxft/0P1frrNGocgjZbx/335ZR1
    LbuEvA1YqZJTWy6QRAYweEqFS4FKClBB5iw4bAueQHKSOh5u67jZrfk8KCcNWQZgbFcq
    yZNQcusn/A5T74F8x+cGK0n5/SvvY8+PTqwpy1aaHnXAdu+Ydgws4jhTIlUiOYwGaqIH
    7b20CpzUNEPOWFIXiib2rtjw711lahlhwT6UTC6p2f2hz7zTnrIdSjInCmTdqj6W8lpY
    yfTbT3HnUkim3/JzPkgDeB+7P+62pbX9uSYMw3YkHdRR1wR1T1PbBfj/ZclLSqSCSayU
    /zGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1687765178;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=nxfxj675BKDRAzZ8yMzfvuth9ryuoohsZaASpKwPFw8=;
    b=dyvO8bV/OTy7TOSISeGtzqX/mi7T4FItWk5NV0xsYteI0Fb0PZGoKOoVUjX0epjb8A
    4MjEQ6lygvGbh58WufmPBI0UF0kBuyvuDaZYrgCLD5EsV3RH7+4k/aTqgS8iMG6Tw7hJ
    rvGZmp2L2z0RirKQ/tHvu+PSLPAuu/W5KNGpXTClSPxpMepCKQwWdFBn+mFbVQvqmimx
    d6dIQmIGSnSV6jr5y8EYY/dbmQKXiwTutOmmd6ADU0mfnjej1vuyx9YJEPSfMam9VKMn
    dBuLFDoZZxplgFh6OzRKsRhjfEdjvM+/J4Pi5m40Yqy44SzL6yVwydRT6/VdedvlN+vl
    tMxA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1687765178;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=nxfxj675BKDRAzZ8yMzfvuth9ryuoohsZaASpKwPFw8=;
    b=fanEPfZ20ZwDWx11ndH/A2c5RZ1xwUdeXZn2T8hM3ASsWVbk3J3c/DYIzApa0OB9YX
    EXWtkiCSQUwkrgBzETCuW9MpjvI6iM1dhsR0nOYoMeY4ZsXZ827i3hr+9umQem+NOMeS
    Hgpv1wWDw6o59LK1ZGz2sZTftxSTEL/zweQnI7xPO0HMMN5Qv/q43fhn/t2MOqaruVwb
    /mjt/RfU2HUIWu+ES2P6DMzA/R9Ee8f6OM4FhPIietqaVyhtIe7NJgLMWX05L0fFB50g
    ocaDBEGLu58yuEnS6ev/UoVBiweHAjeXJ11hmEpAMSRoYs9QxxgCMRMVLaIzKji6GEdm
    +lCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1687765178;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=nxfxj675BKDRAzZ8yMzfvuth9ryuoohsZaASpKwPFw8=;
    b=Vv9yKO1i0iSKS5vl6NMcDdIWUO23D1zUP9BI0w4JUBvij5RFOh1eUv3l+5aNNYNRkU
    9d6kPPzWbOTK0JrCAGAw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u266H5F2OxJAdLOdLjE="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.6.0 AUTH)
    with ESMTPSA id D0d0a8z5Q7daWsX
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 26 Jun 2023 09:39:36 +0200 (CEST)
Date:   Mon, 26 Jun 2023 09:39:31 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>, agross@kernel.org,
        andersson@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, nikita@trvn.ru, robh+dt@kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: msm8939-samsung-a7: Add initial
 dts
Message-ID: <ZJlAs768g_lj0QuQ@gerhold.net>
References: <20230623100135.5269-1-linmengbo0689@protonmail.com>
 <20230623100237.5299-1-linmengbo0689@protonmail.com>
 <5fbba4e8-a8d9-0e99-e112-31b5781c1648@linaro.org>
 <20230623104647.5501-1-linmengbo0689@protonmail.com>
 <71ae3799-4668-891c-c32d-d36da655d56d@linaro.org>
 <ZJiY1PYtfeIN13ZG@gerhold.net>
 <2e7b0647-b108-5364-a7cf-955cacf9b322@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e7b0647-b108-5364-a7cf-955cacf9b322@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 01:05:22AM +0100, Bryan O'Donoghue wrote:
> On 25/06/2023 20:43, Stephan Gerhold wrote:
> > Is it really worth it to support a half-working bootloader though?
> 
> > No one will ever be able to use this properly without fixing the
> > bootloader. SMP doesn't work with the stock bootloader, many devices
> > need display panel selection in the bootloader and on some Samsung
> > devices there is not even USB and UART without special fixes in the
> > bootloader.
> 
> Why set the bar higher than necessary to boot a kernel though ?
> 
> Its two lines in a dts.
> 

I see your point but after adding some really weird workarounds for
various devices in lk2nd I can't help seeing it more complicated.

Adding "just two lines in a dts" is the general case, but I can also
give plenty other examples where one has to:

  - Duplicate the entire downstream MDSS/MDP/display DT nodes because
    the bootloader uses them to initialize the display (older Sony
    MSM8974 devices) [1]

  - Add random DT nodes because the stock bootloader insists on updating
    random DT properties in them [2]

  - Use a custom bootloader anyway to boot 64-bit Linux, because the
    stock bootloader doesn't implement the 32-bit -> 64-bit switch
    (most of these devices used ARM32 on the stock Android)
    [I don't have a full overview which devices need this because
     we have never tested booting mainline Linux with the stock
     bootloader on most devices]

You also need to be really careful when building the Android boot
images. qcom,msm-id/board-ids are not unique, so when you use the
typical "dtbTool" building process which bundles all DTBs in
arch/arm64/boot/dts you risk device damage. Chances are good that the
bootloader will pick the wrong DTB, potentially with wrong regulator
voltages or anything like that.

When qcom,msm-id/board-id are missing such mistakes cannot happen
because the stock bootloader will just refuse to boot it. Personally I
actually consider that to be a good thing because booting with the stock
bootloader is almost always a naive mistake made by end users that have
no experience with the whole complicated DTB selection story.

I won't object to adding the properties but I also don't really see a
use case for them. People porting devices can easily add them when
building a custom kernel. End users want the full functionality
(including SMP) so if they boot through the stock bootloader it's most
likely accidental.

Thanks,
Stephan

[1]: https://github.com/msm8916-mainline/lk2nd/tree/master/dts/msm8974/sony
[2]: https://github.com/msm8916-mainline/lk2nd/blob/dd850aeb0c348cea085db8013f578615715cdd7f/dts/msm8916/msm8916-motorola-surnia.dts#L21-L32
