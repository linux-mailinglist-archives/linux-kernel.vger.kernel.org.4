Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7542D719C35
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 14:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbjFAMeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 08:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjFAMeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 08:34:12 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79838133;
        Thu,  1 Jun 2023 05:34:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685622848; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=S3TBJ4EETCTJKpfs1QEg8mc0iQOxrlN0wStMeC5mPmNTQBeTWoCFzc+/KsfzGpSHbW
    hXatTPRtsR1pQ05kaNiqf1uHM6EmZyZ7+zp/lN+dMpApVomP11+VbHL8AqpsjJQVvRRZ
    4+wwhy4sxQgCawlC6oQEixBPGh9LxvZ/s0/ek2JFmbnd0CTIWAeMclJr5pC+AumPafNm
    AciTyhiaUHhxiWBNUQZYnDllKX802z3zJSBrU2c4BAVJduaZ4Q6yARUAF1uSDfxvUqKn
    x7Zm+LT7hI8AhJP8/30MRU/ZU0Eu/f6JhB2T55kHsjOuloiAVyeVtccrkHvGYo3E9UXt
    C90Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685622848;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=+p5IHgtCJ++8nSCghrBfYm3V7/hpk9AekMBHzhUufmw=;
    b=TCIbyLUdBwYatC5Qzcv+0rNQMwMgi4FxnNfiuO/UmeFeafA0/LZCHPgpJYnmn1qg+S
    UKcrUUC7FYfTlXymbXoYyXUcys1LO8O/0cuWM0fR2o+Ubgk6tPTkWw7FIP/gxcW/rQXz
    4SwI1wxMjFr734f7qqGj5oxlyUkgBrNLHgwonRI32mwud25qV3NWwgPEtK2e4/Dwfikd
    kxzx3A7/BQX5F3Wqgfdl4r6M1+VqNsGJzzBKMWFIzhFXrp8o/dyTeKnkN5EGQt2JwSbc
    fV/SzW5nhpBS4vS2BJeWx0sE/s8d8RoeiC6WIxM7rEhSKlGVvKTXgcPtV8HrdQvwbF9v
    icyQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685622848;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=+p5IHgtCJ++8nSCghrBfYm3V7/hpk9AekMBHzhUufmw=;
    b=XLt1PbAKn5SRWofP0EC/8zRj9xmoVvk5qlUiOwIme2QmDSBmBx6AS80jQQQ0Nz1PCY
    ++BieydRN9J92FdNrsYVIWjNT/UttScAdvFTBCvRJpSzpKU0osbUZHUS4kms3BTboJ1R
    e8WoiyimUrye08j0fAT54jgPZwu5hgCQQ8TYtAb5c+2yOgfEh3xGE0kByYD7EyJbrw/V
    yt03/KqT9w+Prf+ktKoNYW/1wjfcMHQTrtIztRydV6SsjIDk6hU8O1NATbyWtjbT7V+e
    V+gvKEqjlvL80dM++Baq/0ZamodxrUVg2ru6fAYANPZTMDHqGFHafm/ptwQy8nBIJ2/c
    XRyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685622848;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=+p5IHgtCJ++8nSCghrBfYm3V7/hpk9AekMBHzhUufmw=;
    b=Bdcp32Svcck/rleKarQHmuINUKKaHfaMODtq8EDOz5RPqzMylJ0xDzd50lOUL02/sc
    tyhyOlDYXjWfjT8pj7CQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA9J/h"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az51CY7qxR
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 1 Jun 2023 14:34:07 +0200 (CEST)
Date:   Thu, 1 Jun 2023 14:34:00 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: reserved-memory: rmtfs: Allow guard
 pages
Message-ID: <ZHiQON3Or-JCGMur@gerhold.net>
References: <20230530233643.4044823-1-quic_bjorande@quicinc.com>
 <20230530233643.4044823-2-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530233643.4044823-2-quic_bjorande@quicinc.com>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 04:36:41PM -0700, Bjorn Andersson wrote:
> On some Qualcomm platforms it's required that the rmtfs memory is not
> placed adjacent to allocations performed by other clients. Some
> DeviceTree authors have solved this by reserving the space around
> the region, but this prevents such author to use rely on the OS to place
> the region, through the use of "size" (instead of a fixed location).
> 
> So introduce a flag to indicate that guard pages should be carved at the
> beginning and end of the memory region. The user shall account for the
> two 4k blocks in the defined size.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
> 
> Changes since v1:
> - Drop qcom,alloc-size in favour of using reserved-memory/size
> - Introduce explicit property to signal that guard pages should be
>   carved out from this region (rather than always do it in the dynamic
>   case).
> 
>  .../bindings/reserved-memory/qcom,rmtfs-mem.yaml           | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml b/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml
> index bab982f00485..26e24e7b08cf 100644
> --- a/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml
> +++ b/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml
> @@ -26,6 +26,13 @@ properties:
>      description: >
>        identifier of the client to use this region for buffers
>  
> +  qcom,use-guard-pages:
> +    type: boolean
> +    description: >
> +      Indicates that the OS should ignore the first and last 4k block of the
> +      memory region, for the purpose of ensuring that the allocation is not
> +      adjacent to other protected regions.
> +

The name "page(s)" is kind of ambiguous nowadays given that systems are
configured with a variety of page sizes other than 4k.

I wonder if it would be more clear to add the actual size of the guard
pages to the device tree, e.g.

	rmtfs {
		compatible = "qcom,rmtfs-mem";
		size = <(2*1024*1024 + 2*4096)>;
		qcom,guard-size = <4096>;
	};

This could also handle a different padding - in the unlikely case that
this is needed on some platform...

It's probably also fine the way you added it though, this is just
a random thought I had. :)

Thanks,
Stephan
