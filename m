Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741E570D16D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 04:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbjEWCkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 22:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbjEWCkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 22:40:01 -0400
Received: from devico.uberspace.de (devico.uberspace.de [185.26.156.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42973E9
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 19:39:57 -0700 (PDT)
Received: (qmail 7637 invoked by uid 990); 23 May 2023 02:39:55 -0000
Authentication-Results: devico.uberspace.de;
        auth=pass (plain)
MIME-Version: 1.0
Date:   Tue, 23 May 2023 02:39:50 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From:   "Leonard Lausen" <leonard@lausen.nl>
Message-ID: <49d175ec16e3f65a18265063e51092ee8d0d79c1@lausen.nl>
TLS-Required: No
Subject: Re: [PATCH] Revert "drm/msm/dp: Remove INIT_SETUP delay"
To:     "Abhinav Kumar" <quic_abhinavk@quicinc.com>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
        "Bjorn Andersson" <andersson@kernel.org>
Cc:     regressions@lists.linux.dev,
        "Bjorn Andersson" <quic_bjorande@quicinc.com>,
        "Rob Clark" <robdclark@gmail.com>,
        "Stephen Boyd" <swboyd@chromium.org>,
        "Kuogee Hsieh" <quic_khsieh@quicinc.com>,
        "Johan Hovold" <johan+linaro@kernel.org>,
        "Sankeerth Billakanti" <quic_sbillaka@quicinc.com>,
        "Sean Paul" <sean@poorly.run>, "David Airlie" <airlied@gmail.com>,
        "Daniel Vetter" <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, "Nikita Travkin" <nikita@trvn.ru>
In-Reply-To: <1345a125-f745-4fe3-0f5e-bfe84225958d@quicinc.com>
References: <1345a125-f745-4fe3-0f5e-bfe84225958d@quicinc.com>
 <b0cc40d5-6de1-91cc-e2cd-f47cc53551e4@quicinc.com>
 <ebbcd56ac883d3c3d3024d368fab63d26e02637a@lausen.nl>
 <20230508021536.txtamifw2vkfncnx@ripper>
 <3802269cd54ce105ef6dece03b1b9af575b4fa06@lausen.nl>
 <ad351c02-1c29-3601-53e8-f8cdeca2ac63@linaro.org>
X-Rspamd-Bar: +
X-Rspamd-Report: MIME_GOOD(-0.1) BAYES_HAM(-0.000128) SUSPICIOUS_RECIPS(1.5)
X-Rspamd-Score: 1.399871
Received: from unknown (HELO unkown) (::1)
        by devico.uberspace.de (Haraka/3.0.1) with ESMTPSA; Tue, 23 May 2023 04:39:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=lausen.nl; s=uberspace;
        h=from;
        bh=2py7sSWEr5LcTyrtnazJBVn2Bb0q8G3RqcXydECid+g=;
        b=n4BaIr5cgPGpaY3VsxvHYwHY2OFbcIsnsLMF+WZjO5zBzudI+hklJbnyT3jwDCylB5xzHTyulc
        JOVSV42wZ5o4b1XlCxXjGdnDNuldhk/KDYlYP/MgEiyLO9tBS/G2EAFnO1K6AldFnRqjtygruD6L
        PLFLjlUOfT164e+5rgxSNZrizg/e8xjQIt1ecLsaHFI/ZMN0Sk/pVca7q9inPYHMqpnIN/5/dZFn
        PhPlW2THAPx4G6AmJt8Zkz0oEoNVbZ0xmxr1QNUTFMn9pQorqNBh7kcIsYHpXLDLi5Rd0pqAEf4P
        g75xmDs+EtWpH28yQr9koJBcUT4dCL/dWG1wmMbSzox0xSwyisovpBGEKlY+PtS3sR83n/dQ0BrU
        IEJwvelq7LqPQ9eUFSY4FRCaM1ap4wEvinBpIG0m2CwKh7WdU5XOMD8s4CTB1FUPHaeu/Ae1iwqs
        mUT6EG9Yx3yWQuh8CHucbntKbiWXvo7WlJe0L+Jdy/vJDvp5z2+YeDTOkkHxnLlyjSACv/g2cApk
        hrRsqGIwWbqBT9L6qczY857RL7xdmY2kkgY3osn2YK2At/UgUriA51to6ZIq1VKZ7C75W4fyH9Tm
        0ENPzUD92avmLXqnHoYJJMLzgMNPVkfwji/OGLgBOHY6yfym4aYvucjEQsrqQTx9MNFHs+DxoJi/
        A=
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Abhinav Kumar <quic_abhinavk@quicinc.com> writes:
>>>> There is no need to add the 100ms delay back yet.
>>>>
>>>> thanks for posting this but NAK on this patch till we post the fix t=
his
>>>> week.
>>>>
>>>> Appreciate a bit of patience till then.
>>>
>>> This regression is already part of the 6.3 stable release series. Wil=
l
>>> the new patch qualify for inclusion in 6.3.y? Or will it be part of 6=
.4
>>> and this revert should go into 6.3.y?
>>=20
>>=20This is a tough situation, as landing a revert will break x13s, as n=
oted=20
>>=20by Bjorn. Given that the workaround is known at this moment, I would=
=20
>>=20like to wait for the patch from Abhinav to appear, then we can decid=
e=20
>>=20which of the fixes should go to the stable kernel.

I wasn't able to find new patches, though may have missed them. Is there
a decision yet how to proceed with this regression? 6.2 now being EOL
may make this a good moment to decide on the next steps.

>>> [=C2=A0 275.025497] [drm:dpu_encoder_phys_vid_wait_for_commit_done:48=
8]=20
>>>=20[dpu error]vblank timeout
>>> [=C2=A0 275.025514] [drm:dpu_kms_wait_for_commit_done:510] [dpu error=
]wait=20
>>>=20for commit done returned -110
>>> [=C2=A0 275.064141] [drm:dpu_encoder_frame_done_timeout:2382] [dpu=20
>>>=20error]enc33 frame done timeout
>
> This is a different crash but the root-cause of both the issues is the=
=20
>=20bridge hpd_enable/disable series.
>
> https://patchwork.freedesktop.org/patch/514414/
>
> This is breaking the sequence and logic of internal hpd as per my=20
>=20discussion with kuogee.
>
> We are analyzing the issue and the fix internally first and once we=20
>=20figure out all the details will post it.

Thank you!
