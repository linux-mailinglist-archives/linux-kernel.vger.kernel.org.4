Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F836E8AF6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 09:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbjDTHKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 03:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233986AbjDTHKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 03:10:40 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA0E26B3;
        Thu, 20 Apr 2023 00:10:36 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33K2rtba028337;
        Thu, 20 Apr 2023 09:10:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=53KGJ1211Er3xybNs3kQiclgKJZtxeoNmmsAg952A9k=;
 b=ZEa03B/Y4eDcCU8+qI7ELgbfcDKfELizrn2fOkk/mpE/+qElmn7MH0FBJtwd/WxUmt0Q
 oKkARdjp9fUebJVl4UY1Xy+5H3lD+v9unsp00b2DHhWLXcKUhcJGYIXPxQr11P3k7Jv3
 aC988Emvo/hSGrTG1aNFAc4i6NiRnYCYm5PyDvdW2jWObQvQgOjG4W9gOPjX/qbUP0HV
 uwN4cGYF25C6UwywUzKawifQOtPK/t7IIUU4p3Qw9O2GpXybGAUtkXE1cALJsNeeCwK9
 aHSc+W45qGLN54LKRtbGxUOcG+NHMyoLAVsfg6oiIq4oBoXv718q38UopJdaTEE8G9rR Iw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3q2dyeeu8j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 09:10:31 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6EEAF10002A;
        Thu, 20 Apr 2023 09:10:27 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6692821160D;
        Thu, 20 Apr 2023 09:10:27 +0200 (CEST)
Received: from [10.201.21.178] (10.201.21.178) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 20 Apr
 2023 09:10:24 +0200
Message-ID: <e6ef7616-d64d-9ad7-753a-6a7ab2e0b817@foss.st.com>
Date:   Thu, 20 Apr 2023 09:10:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V6 0/3] rpmsg signaling/flowcontrol patches
Content-Language: en-US
To:     Sarannya S <quic_sarannya@quicinc.com>,
        <quic_bjorande@quicinc.com>, <swboyd@chromium.org>,
        <quic_clew@quicinc.com>, <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>
References: <1681971690-28858-1-git-send-email-quic_sarannya@quicinc.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Organization: STMicroelectronics
In-Reply-To: <1681971690-28858-1-git-send-email-quic_sarannya@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.178]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-20_04,2023-04-18_01,2023-02-09_01
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sarannya,

On 4/20/23 08:21, Sarannya S wrote:
> Added new IOCTLS- RPMSG_GET_OUTGOING_FLOWCONTROL and RPMSG_SET_INCOMING_FLOWCONTROL
> to get/set the rpmsg char device's flow control signal.
> Updated the cmd name 'RPM_CMD_SIGNALS' to 'GLINK_CMD_SIGNALS'.
> Changed 'remote_flow' to bool type, and updated it's evaluation.
> Updated evaluation of 'set' in rpmsg_char as 'set = !!arg'.
> Add destination address of endpoint as parameter in rpmsg_set_flow_control.
> Addressed review comments to change variable names/descriptions.
> 
> Chris Lew (2):
>   rpmsg: glink: Add support to handle signals command
>   rpmsg: char: Add RPMSG GET/SET FLOWCONTROL IOCTL support
> 
> Deepak Kumar Singh (1):
>   rpmsg: core: Add signal API support

Please increase the version each time you push an update, otherwise it is very
difficult to track the update.
So this one should be V7

It is also helpful for reviewers and maintainers to include in your cover-letter
 a summary of the changes from the previous version.

Regards,
Arnaud

> 
>  drivers/rpmsg/qcom_glink_native.c | 64 +++++++++++++++++++++++++++++++++++++++
>  drivers/rpmsg/rpmsg_char.c        | 49 ++++++++++++++++++++++++++----
>  drivers/rpmsg/rpmsg_core.c        | 21 +++++++++++++
>  drivers/rpmsg/rpmsg_internal.h    |  2 ++
>  include/linux/rpmsg.h             | 15 +++++++++
>  include/uapi/linux/rpmsg.h        | 11 ++++++-
>  6 files changed, 155 insertions(+), 7 deletions(-)
> 
