Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990E15B8244
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 09:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiINHvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 03:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiINHvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 03:51:08 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF04A2A266;
        Wed, 14 Sep 2022 00:50:59 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28E55ft8013611;
        Wed, 14 Sep 2022 09:50:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=pYGgu5rOLOhul9DJXw1aqoaq6vf4xJjwRWFbMfPDlA0=;
 b=5OYcofgipre4PQWTMHddfC2faViTEibm/LEh/ls+7gvgxCWS8t/P6K6M5jzOSunKImJb
 TZZJ1aVKW7PepdVZsaaGq9mqCXGAl2ViGpQ3T6+v6z04+maihAsf3kON+f7WOerDepLk
 cvpsXznQmRXWUAP1jqstXeduWHAc3/Bjn9jwKS50UlfI/1mrMdnhiY4EsrL6QGoJHRc8
 3OKI/ZI8a1h5PtDXzGFO8/XBNWT03BmioH6RNc94RSVZ0Xyq19Eize61Rshl2o0U7HxW
 N1oryXHBORrvvatx44eH/LcUyTazJ2VuCQIdbaAlqf2CZgke1JPJOiakNugHJqt+bElr Mw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3jjxxckgyh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 09:50:53 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DE1C010002A;
        Wed, 14 Sep 2022 09:50:49 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node5.st.com [10.75.129.134])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D946F2138FF;
        Wed, 14 Sep 2022 09:50:49 +0200 (CEST)
Received: from [10.201.22.245] (10.75.127.121) by EQNDAG1NODE5.st.com
 (10.75.129.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Wed, 14 Sep
 2022 09:50:49 +0200
Message-ID: <74224354-8543-559b-240b-0eda4d68fc52@foss.st.com>
Date:   Wed, 14 Sep 2022 09:50:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V3 0/3] rpmsg signaling/flowcontrol patches
Content-Language: en-US
To:     Deepak Kumar Singh <quic_deesin@quicinc.com>,
        <bjorn.andersson@linaro.org>, <swboyd@chromium.org>,
        <quic_clew@quicinc.com>, <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>
References: <1663133102-10671-1-git-send-email-quic_deesin@quicinc.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
In-Reply-To: <1663133102-10671-1-git-send-email-quic_deesin@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.121]
X-ClientProxiedBy: GPXDAG2NODE4.st.com (10.75.127.68) To EQNDAG1NODE5.st.com
 (10.75.129.134)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_02,2022-09-13_01,2022-06-22_01
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Deepak,

On 9/14/22 07:24, Deepak Kumar Singh wrote:
> [Changes from V2]:
> Trivial review comment fixes.
> Avoid TIOCM_DTR etc signals in glink layer, use native signal macros only.
> Glink layer to provide only flowcontrol on/off interface, no specific signal passing/receiving to client.


Please, could you have a look to my series that implements
your proposed interface for the virtio rpmsg [1]?
It would be nice that your API takes into account update to
support of the rpmsg virtio implementation proposed in [08/10] rpmsg: Add the
destination address in rpmsg_set_flow_control[2]

Thanks,
Arnaud

[1] https://lore.kernel.org/lkml/e54bcfcb-8e37-9caa-b330-a7411820b7ce@foss.st.com/T/
[2]https://lore.kernel.org/lkml/e54bcfcb-8e37-9caa-b330-a7411820b7ce@foss.st.com/T/#m7340a8e70fb0d8935869c4cef96863abda555c96

> 
> Deepak Kumar Singh (3):
>   rpmsg: core: Add signal API support
>   rpmsg: glink: Add support to handle signals command
>   rpmsg: char: Add TIOCMGET/TIOCMSET ioctl support
> 
>  drivers/rpmsg/qcom_glink_native.c | 63 +++++++++++++++++++++++++++++++++++++++
>  drivers/rpmsg/rpmsg_char.c        | 60 ++++++++++++++++++++++++++++++++-----
>  drivers/rpmsg/rpmsg_core.c        | 20 +++++++++++++
>  drivers/rpmsg/rpmsg_internal.h    |  2 ++
>  include/linux/rpmsg.h             | 15 ++++++++++
>  5 files changed, 152 insertions(+), 8 deletions(-)
> 
