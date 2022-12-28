Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7955657646
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 13:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbiL1MDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 07:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiL1MCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 07:02:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB0D1173;
        Wed, 28 Dec 2022 04:01:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD9316136E;
        Wed, 28 Dec 2022 12:01:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D00DC433EF;
        Wed, 28 Dec 2022 12:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672228912;
        bh=mSKLstnN8UErpGX3SpV286l5MB64KVuBWn9aENVo6uU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uP6BKCG4B92YvGOjiIMg5muVDxbIR1nd7iCwR6y3ZECXLYn+jcOv8+WyvpBhqZNnc
         sTSfBsb28qm0npZCoSC+Ow42cHqn1uriOaWiOG36j28ZmFr9UCd0lmuJ7l5Cu3AMEA
         4ps62l4Z4L9rOAXMbMFQGQyX02Kl8JMfKORoAO2HDAyWP2Wf524O8rrCwZYzEHDDv2
         Vz0or3eSbDVwbGKPxDP5roUMd2giRm10t0Q4BjyxS80sNTRoxc/GukOJM3tO3mOGq2
         d10+o4uPHaRw5V0PGiZheyYtxcEMFum6DQC74tuSoZd0Gw/0thdZAmwoEEdNmCcGtL
         GaP3Odh+clihg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pAV86-0004WX-St; Wed, 28 Dec 2022 13:01:54 +0100
Date:   Wed, 28 Dec 2022 13:01:54 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     agross@kernel.org, srinivas.kandagatla@linaro.org,
        konrad.dybcio@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 0/3] arm64: dts: qcom: sc8280xp: add audio support
Message-ID: <Y6wwMo8KLulNAoiU@hovoldconsulting.com>
References: <20221123104342.26140-1-srinivas.kandagatla@linaro.org>
 <167220221217.833009.5730063788271218487.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167220221217.833009.5730063788271218487.b4-ty@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 10:36:56PM -0600, Bjorn Andersson wrote:
> On Wed, 23 Nov 2022 10:43:39 +0000, Srinivas Kandagatla wrote:
> > This patchset adds audio support for sc8280xp Lenovo x13s.
> > Support for Headset Playback/Capture, Speaker Playback and DMIC is
> > tested.
> > 
> > A prebuit ASoC topology file available at
> > https://git.linaro.org/people/srinivas.kandagatla/audioreach-topology.git/tree/prebuilt/SC8280XP-LENOVO-X13S-tplg.bin
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/3] arm64: dts: qcom: sc8280xp: add gpr node
>       commit: e73defb2deee74f3f4988196bf0c21782dffa415
> [2/3] arm64: dts: qcom: sc8280xp: add SoundWire and LPASS
>       commit: c18773d162a63f65024e80ae355e3fbc923e7255
> [3/3] arm64: dts: qcom: sc8280xp-x13s: Add soundcard support
>       commit: f29077d8665221ba2802a29ee7bd9fcef66cde81

Perhaps merging this was a bit premature. I just gave it a spin, but
this is apparently not even expected to work without various changes
that are still work in progress. For example, the codecs fails to probe
with:

[   11.077727] qcom-prm gprsvc:service:2:2: DSP returned error[100100f] 1
[   11.077926] rx_macro: probe of 3200000.rxmacro failed with error -22

and you need an out-of-tree hack to get around that:

	https://git.linaro.org/people/srinivas.kandagatla/linux.git/commit/?h=lenovo-x13s-6.1.0-rc7-audio&id=0bffb619bf7929c56b7458af3a583fa9ce87fc26

I learned that the hard way after a debugging session.

Even with those hacks in place, I see:

[   14.466733] qcom-soundwire 3330000.soundwire-controller: qcom_swrm_irq_handler: SWR bus clsh detected
[   14.522324] qcom-soundwire 3330000.soundwire-controller: swrm_wait_for_frame_gen_enabled: link status not disconnected
[   14.522372] qcom-soundwire 3330000.soundwire-controller: link failed to connect

so this does not look like it was ready to be merged. I'm still not sure
what else is needed, but there are a bunch of other work-in-progress
changes in the above branch.

Srini, next time can you please document such dependencies in the cover
letter to avoid having people debug things that are not even supposed to
work yet and so that we can hold-off on merging the dts changes until
driver support in place.

Johan
