Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F4D67FD8F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 09:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjA2IMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 03:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjA2IMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 03:12:35 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C945C1C597;
        Sun, 29 Jan 2023 00:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1674979946; x=1706515946;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=CqZksGF+4lRPmEfO+ywdHJIsS5gHOVbEo/YHqISB09A=;
  b=J/ycF3BuTTBdSe9d+HBY+Tm5XIOi6I2fuSwqYN5EJXXjtvb2cxYStQaD
   iBwG88ED9mU32orvv+GX0FTzluXSD8DZXWKvtOYiJUGls3mVDJlw2N6V4
   GnAkk+UPKVvIdbvs1wjbKrh9E9sb1/nw90D1WWfc6akg/PUFIn64g4mn3
   Y=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 29 Jan 2023 00:12:26 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.45.79.139])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2023 00:12:26 -0800
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sun, 29 Jan 2023 00:12:23 -0800
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <quic_namajain@quicinc.com>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <konrad.dybcio@somainline.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_tsoni@quicinc.com>
Subject: Re: soc: qcom: socinfo: Add support for new field in revision 17
Date:   Sun, 29 Jan 2023 13:42:03 +0530
Message-ID: <1674979923-11538-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20230127041200.29094-1-quic_namajain@quicinc.com>
References: <20230127041200.29094-1-quic_namajain@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Add support for new field coming with socinfo structure under v17 to get
>hardware platform's oem variant id. This is to enable OEMs to have minor
>changes in the board, but to use the same platform subtype as the one
>supported by Qualcomm. The new field is to be used in platform overlay
>file. Default value is 0, reserved for Qualcomm platforms. Also, add
>debugfs support to read this field for a device.
>
>Signed-off-by: Naman Jain <quic_namajain@quicinc.com>

Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh
