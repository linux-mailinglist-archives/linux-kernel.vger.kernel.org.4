Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149A867AA11
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 06:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbjAYFqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 00:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjAYFqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 00:46:36 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA06C11661
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 21:46:33 -0800 (PST)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230125054629epoutp01e368db91d8f99d2cc5d7c915d9ae195c~9dxno24VE1288912889epoutp01i
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 05:46:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230125054629epoutp01e368db91d8f99d2cc5d7c915d9ae195c~9dxno24VE1288912889epoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1674625589;
        bh=NEwNm/LwY6eOUXbJxfSdsnrHPfYhWSnwXjX0rr9rmhU=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=RhPMlKHU+owlp3B3G2FfLUkxn5TDNnAyPFZOU7JAEPMwSRPb2cwMeYmTB/VDdxRjJ
         upRNM+SM/ROBKOUjklq4cQbk+6ckA/iq8+5F9U/155Qlt2zbDSsND8BT3lYgh9+Uv7
         WRDpkBPd3aW1RSUEnpm8yTBmxLaOKYNejrbcOvh8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20230125054628epcas1p4f84952b2c9ef9b88d805454a009cf28c~9dxnCntqR3064130641epcas1p4C;
        Wed, 25 Jan 2023 05:46:28 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.136]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4P1tBD0431z4x9Q2; Wed, 25 Jan
        2023 05:46:28 +0000 (GMT)
X-AuditID: b6c32a38-39fff70000029402-00-63d0c2328958
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        32.3A.37890.232C0D36; Wed, 25 Jan 2023 14:46:26 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: [PATCH] PM / devfreq: Fix build issues with devfreq
 disabled
Reply-To: myungjoo.ham@samsung.com
Sender: MyungJoo Ham <myungjoo.ham@samsung.com>
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     Rob Clark <robdclark@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <CAF6AEGud-ESF=VgcaSFzKsWas0H5eSXZDdZGcnd8Ju=pr-W2EQ@mail.gmail.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230125054626epcms1p38d34dc65cbc9cb29dd707a4b2cac8fb4@epcms1p3>
Date:   Wed, 25 Jan 2023 14:46:26 +0900
X-CMS-MailID: 20230125054626epcms1p38d34dc65cbc9cb29dd707a4b2cac8fb4
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmnq7RoQvJBq9XqVtc//Kc1eLK1/ds
        FnOen2W0OH9+A7vF2aY37BaXd81hs/jce4TRYstqe4trPx8zWzxf+IPZgctjdsNFFo+ds+6y
        e2xa1cnmcb/7OJNH35ZVjB6fN8kFsEVl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpa
        WpgrKeQl5qbaKrn4BOi6ZeYAXaakUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTAt
        0CtOzC0uzUvXy0stsTI0MDAyBSpMyM54dHoRe8E+7ooPe7+yNjDu5uxi5OSQEDCRaHlxirGL
        kYtDSGAHo0Tn2rcsXYwcHLwCghJ/dwiD1AgL+EtMWdzCBGILCShJNNzcxwwR15foeLCNEcRm
        E9CV2LrhLguILSLgKTFt33p2kJnMAj3MElc6jzJBLOOVmNH+lAXClpbYvnwrWDOnQKDEj7Wt
        7BBxUYmbq9/C2e+PzWeEsEUkWu+dZYawBSUe/NwNFZeSeLJzMhvIMgmByYwSJ08cZ4Rw5jBK
        TNvwjg2iSl/izNyTYDavgK/EgrsPWEG+ZBFQlZj5GGqZi8TX3mlgQ5kF5CW2v53DDFLCLKAp
        sX6XPkSYT+Ld1x5WmF92zHsC9ZeaxKHdS6DGyEicnr4Q6k4PiV9bX7JDAreXSWLVlqMsExjl
        ZyHCdxaSbbMQti1gZF7FKJZaUJybnlpsWGACj9Lk/NxNjOCkqWWxg3Hu2w96hxiZOBgPMUpw
        MCuJ8PbMPp8sxJuSWFmVWpQfX1Sak1p8iNEU6M2JzFKiyfnAtJ1XEm9oYmlgYmZkbGJhaGao
        JM4rbnsyWUggPbEkNTs1tSC1CKaPiYNTqoHJT3v1Gd7eGzfPO/q8MirN3zanzMFNcM3x/54L
        nbi6S2Uq9qWsjzjKuSn6y4aG921T3lY8dTx1pXnfnOmpJW57/Yz+COz6J3s91Nzuun3hfacd
        J5qF/H69aWp4ZZZ29aStp1CBW/WJRP9Qr4V1iomG3y7sevO0rtSnPeJo7oGVTjJxs5oNPupm
        3T90WW2p9u7u6MNB1ydW82WLFWxK9D+7KkbigrWb0Mcd4ZHPuTg3nplQduJVXeD/Y0GNQi8E
        v2pdEFhwi7NRN+90bOK6TQ+eJsvbOS12OLRqYfvTuVyGqgbumx+8uRsU7nyPf8drL+ezN3u9
        ba9ZMxa0ngiPltT7XOa782/nI946HjeFLSFKLMUZiYZazEXFiQDi5e2cIwQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230123153745epcas1p17e57cf83ed371e86258139473befc615
References: <CAF6AEGud-ESF=VgcaSFzKsWas0H5eSXZDdZGcnd8Ju=pr-W2EQ@mail.gmail.com>
        <20230123153745.3185032-1-robdclark@gmail.com>
        <20230125040403epcms1p1646e9668b87df3e9c344ad58d39b6eb6@epcms1p1>
        <CGME20230123153745epcas1p17e57cf83ed371e86258139473befc615@epcms1p3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Tue, Jan 24, 2023 at 8:04 PM MyungJoo Ham <myungjoo.ham@samsung.com> wrote:
>>
>> >Sender : Rob Clark <robdclark@gmail.com>
>> >Date : 2023-01-24 00:37 (GMT+9)
>> >Title : [PATCH] PM / devfreq: Fix build issues with devfreq disabled
>> >
>> >From: Rob Clark <robdclark@chromium.org>
>> >
>> >The existing no-op shims for when PM_DEVFREQ (or an individual governor)
>> >only do half the job.  The governor specific config/tuning structs need
>> >to be available to avoid compile errors in drivers using devfreq.
>> >
>> >Fixes: 6563f60f14cb ("drm/msm/gpu: Add devfreq tuning debugfs")
>> >Signed-off-by: Rob Clark <robdclark@chromium.org>
>>
>> Doesn't this imply that DRM_MSM should depend on PM_DEVFREQ ?
>>
>> It appears that gpu/drm/msm/DRM_MSM uses PM_DEVFREQ without actually
>> declaring the dependency on PM_DEVFREQ.
>> You cannot use SIMPLE_ONDEMAND without DEVFREQ.
>
>Possibly that would resolve some issues, and that might have been my
>mistake in assuming that depending on SIMPLE_ONDEMAND implied a
>dependency on DEFREQ (which seems like a reasonable assumption, IMHO)
>
>But AFAICT some kernel configs that could otherwise use DRM_MSM don't
>support PM_DEVFREQ.. either way, lets solve this properly and remove
>needless dependencies on devfreq.
>
>BR,
>-R

Ok. You are enabling struct and enum only and that looks harmless.

PTAL, Chanwoo.

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

Cheers,
MyungJoo.
