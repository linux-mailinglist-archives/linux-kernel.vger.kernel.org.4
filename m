Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258446EA884
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 12:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjDUKob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 06:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjDUKoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 06:44:30 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586923C07
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 03:44:29 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-2fa36231b1cso966259f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 03:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682073868; x=1684665868;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mRR8QtsSmxjRIku5DkJBFiN+Snm7HpPNejtlu92e2h4=;
        b=As8nZXfVquw9bOEdzULHA3Not2GSqD1l15CQ2M3BHZeFQF6QIhBuJXv4rKzXgnCf/x
         hwwmG7K23HRwX4QLME9tdAlnvkQ5pFHWXSMFkDCmffcB0ezeQb80rpw56nYijTG4a66Q
         Z2A+KWB90RYWJ6dVCC9psjN5cJ5O2DAUcyhWPFUHQ93Tz0tfx9OjOOY/jwFRD8YQMzpS
         fQ3cjYV1u4B8kwAGZXKUMWfP4+JLDtEtwufk39DOkVyS27SbYEGiL846EQJucn6CzKdn
         dMhtwuxshqN4keKtc8HQCIILdGRh/C4ZosfNLrYNh5w4F5uJ9NeQxpJlrSxHGohHVs68
         YYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682073868; x=1684665868;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mRR8QtsSmxjRIku5DkJBFiN+Snm7HpPNejtlu92e2h4=;
        b=jASVyUnAaIFYO11DJe2TCb8cMOuPhyloDB4jLLElYpoSg5HEwLLe6pTWc4f2ZgR4mV
         ok1gAzFXSShbyxW0NmcjryhQz2bN0Tkwdi35Exij3TFRNctwz6yb0Wy2BnU4ev/0i+Nd
         fzJeHU85VVN3o6F0p4RTcge4Jv8YpZ0X05ch9TKJT67LHjcs9tp0bq0q0Z9NGj9KYG6R
         4vgALQVl+5W90pZEYPXY9cbH5/1mTQj3u46dPV6IqobBUslib2k+GETXJelvRBbDZ10k
         QAFfpZ2qIx8mi1h27+NM5Nb904wRpcwWXz8+O8lcVmH/p6ICcgd/kvHKplFZqlcc76LJ
         E2kg==
X-Gm-Message-State: AAQBX9e5kzm4InWtPX0tyRFGoKp+St6om9C7pZbrrqdAx2kREnzzcAO6
        Z/Ek8Oxftu8Osjh1kWPwFCzphg==
X-Google-Smtp-Source: AKy350YqVVHeM1QoSPRQ7nVBEFDSMpaL/Zr5lSpChBMc9Htj57WjFH3Pkfbx1Vrf+uv56OTMxBtPBg==
X-Received: by 2002:adf:fecb:0:b0:2cb:2775:6e6 with SMTP id q11-20020adffecb000000b002cb277506e6mr3369289wrs.45.1682073867970;
        Fri, 21 Apr 2023 03:44:27 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f17-20020a5d50d1000000b002e5f6f8fc4fsm4085509wrt.100.2023.04.21.03.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 03:44:27 -0700 (PDT)
Date:   Fri, 21 Apr 2023 13:44:21 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] soc: qcom: rmtfs: Fix error code in probe()
Message-ID: <76b21a14-70ff-4ca9-927d-587543c6699c@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return an error code if of_property_count_u32_elems() fails.  Don't
return success.

Fixes: e656cd0bcf3d ("soc: qcom: rmtfs: Optionally map RMTFS to more VMs")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/soc/qcom/rmtfs_mem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/rmtfs_mem.c b/drivers/soc/qcom/rmtfs_mem.c
index ce48a9f3b4c8..f83811f51175 100644
--- a/drivers/soc/qcom/rmtfs_mem.c
+++ b/drivers/soc/qcom/rmtfs_mem.c
@@ -233,6 +233,7 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
 		num_vmids = 0;
 	} else if (num_vmids < 0) {
 		dev_err(&pdev->dev, "failed to count qcom,vmid elements: %d\n", num_vmids);
+		ret = num_vmids;
 		goto remove_cdev;
 	} else if (num_vmids > NUM_MAX_VMIDS) {
 		dev_warn(&pdev->dev,
-- 
2.39.2

