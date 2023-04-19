Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAF16E7B72
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 16:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjDSOAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 10:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjDSOAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 10:00:45 -0400
X-Greylist: delayed 154347 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 19 Apr 2023 07:00:43 PDT
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A3F83;
        Wed, 19 Apr 2023 07:00:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1681912840; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=pvBk3KjtOqhsVP0fpd8sLK3TZ1iPPEOEMap3voQ1pMPZtV9W8bNXxRx2GNdcl4+TLI
    JS5lpze7kXo5dfPZkUjgI3MDZdanV3cSyIi0FfBu3tZTtmF2MzTO5pS7qOCl9ykEvw2Y
    vhNkZZuclPm+iIzBYGFMa0tE4pfAu8icBlL3XiyM62xUCtutuyqyEJmdGp7dgsNfp9Hx
    3ejg2IqJ1ar/1/dGjvVRRpMsAUWfJghhkpwC4oo0zr5H/0Pg/Ryz3qcbdB+q6rhhMB5O
    CwUdz9HPUi4zUnHcdaeEKL2C554ozIBPQ7gZw+Fc5q1QxUpH4TRIavB8lQDBGbDhsi6C
    eyxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1681912840;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=khgLveWxOtEKwyxE2H65XlSSu/fm5Gz0M5cVj1ZTRVQ=;
    b=j0jO8HFRZgQH8Pqmiqk3dcwZmfdwcBT7smkvNJL2IphNrx2qzyF67lNqlPA4GJWBfY
    X7OqFtHu6698SdycUnVDBt3rCghQXmNWxt6xQH/c2ooTytuwIC/Egt+taERiDWCtBhkc
    BD/TcMkN4EjTDr3zeBFi2Fqv3yoeIMEWI1d1jzk90SLnGNonpjwGb1ORU/wV6NpLMevg
    A7GyqTGIvoudmgESPNI9xAVurZIbJpwp6mdEfjQYzuXsw5YWxdgrXYoRNrcCgNBemH1n
    SHcu+8v0Q3My3FJ6+gSNiV5rB3wzhGzjupQU1bBvuErZ6VTt3rJhhLAONd479a6inNs0
    1V1g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1681912840;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=khgLveWxOtEKwyxE2H65XlSSu/fm5Gz0M5cVj1ZTRVQ=;
    b=eWzHib70vHw+5Bol3kA1vcx3kxZxzTyRGMiJ4zMq5YkjJAl3SKphIGJY15TgkOxJdl
    Pbc4OPFC9gTSmTkI1HphhyRWpL8D8zfOriRmnWtXk+7C8OP3b1Vjnd3X50G3UoBCnOt6
    nmhRugRT4Vw/60zhcl4rna+RL3XeRcr30/3QzCVfnErPTzwu8xjSdQrXuWbCIuUAGKhp
    FoT4qFtlA8sgz0dKK/E2mIzrs/K3jsqA/Owm7FJmp2T60wqCYwJKO8fh3W5tRYj7vCbS
    tE4QAM4cKSgeNQkORn+KvrejqBBOz71jtNM8JoXwA+QumOHOT7mhU0spJlBc4KdeeLcF
    TOTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1681912840;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=khgLveWxOtEKwyxE2H65XlSSu/fm5Gz0M5cVj1ZTRVQ=;
    b=K+LMlUTc2w6j06vhnHh7av6fPcrcYXmZdGiN9nKrW8XxKUT5izZYEYK5wq9H+NbJgA
    NljCDk0AYBjY0BOnidBA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8p+F1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az3JE0el5p
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 19 Apr 2023 16:00:40 +0200 (CEST)
Date:   Wed, 19 Apr 2023 16:00:34 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH RFT v2 01/14] dt-bindings: clock: qcom,rpmcc: Add a way
 to enable unused clock cleanup
Message-ID: <ZD_0AmYU-N5vzv8f@gerhold.net>
References: <20230303-topic-rpmcc_sleep-v2-0-ae80a325fe94@linaro.org>
 <20230303-topic-rpmcc_sleep-v2-1-ae80a325fe94@linaro.org>
 <ZD2YYrOdQMD3pi7u@gerhold.net>
 <d63d4896afe8a1a901470f88862ce608.sboyd@kernel.org>
 <3873483f-7f7d-a146-cca9-b50f054289d4@linaro.org>
 <6407af2a-18c6-9baf-cc9b-dcf7001812b7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6407af2a-18c6-9baf-cc9b-dcf7001812b7@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 01:31:01PM +0200, Konrad Dybcio wrote:
> What should we do about the non-bus RPM clocks though? I don't fancy
> IPA_CLK running 24/7.. And Stephan Gerhold was able to achieve VDD_MIN
> on msm8909 with these clocks shut down (albeit with a very basic dt setup)!
> 
> Taking into account the old interconnect-enabled DTs, some of the
> clocks would need to be on so that the QoS writes can succeed
> (e.g. the MAS_IPA endpoint needs IPA_CLK), it gets complicated again..
> 

I guess MSM8996 is the only platform affected by this? sdm630.dtsi seems
to list the clock already in the a2noc and all others don't seem to have
an interconnect driver yet.

This will be subjective and someone will surely disagree but...

IMO forcing all RPM clocks on during boot and keeping them enabled is
not part of the DT ABI. If you don't describe the hardware correctly and
are missing necessary clocks in the description (like the IPA_CLK on the
interconnect node) then your DT is wrong and should be fixed.

I would see this a bit like typical optimizing C compilers nowadays. If
you write correct code it can optimize, e.g. drop unnecessary function
calls. But if you write incorrect code with undefined behavior it's not
the fault of the compiler if you run into trouble. The code must be
fixed.

The DT bindings don't specify that unused resources (clocks, ...) stay
"magically" active. They specify that that the resources you reference
are available. As such, I would say the OS is free to optimize here and
turn off unused resources.

The more important point IMO is not breaking all platforms without
interconnect drivers. This goes beyond just adding a missing clock to
the DT, you need to write the driver first. But having the max vote in
icc_smd_rpm (somehow) should hopefully take care of that.

> I suppose something like this would work-ish:
> 
> 0. remove clock handles as they're now contained within icc and
>    use them as a "legacy marker"
> 1. add:
> 	if (qp->bus_clocks)
> 		// skip qos writes

Maybe you can just check if all necessary clocks for QOS are there or
not? I don't think it's a problem to skip it on broken DTs. I think it
would be even fine to refuse loading the interconnect driver completely
and just have the standard max vote (as long as that results in a
booting system).

> 
> This will:
> - let us add is_enabled so that all RPM clocks bar XO_A will be cleaned up
> - save massively on code complexity
> 

+1

> at the cost of retroactively removing features (QoS settings) for people
> with old DTs and new kernels (don't tell Torvalds!)
> 

I doubt anyone will notice :p

> This DTB ABI stuff really gets in the way sometimes :/ We're only now
> fixing up U-Boot to be able to use upstream Linux DTs and other than
> that I think only OpenBSD uses it with 8280.. Wish we could get rid of
> all old junk once and then establish immutability but oh well..

Nice, thanks a lot for working on addressing the Qualcomm DT mess in
U-Boot. I've been meaning to work this myself for a long time but never
found the time to start... :')

Thanks,
Stephan
