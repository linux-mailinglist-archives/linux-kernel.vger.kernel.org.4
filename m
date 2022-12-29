Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33987659001
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 18:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbiL2RtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 12:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbiL2RtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 12:49:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8195F1582F;
        Thu, 29 Dec 2022 09:49:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B44061862;
        Thu, 29 Dec 2022 17:49:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8CBAC433EF;
        Thu, 29 Dec 2022 17:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672336154;
        bh=oyyimtOuBkmoKNFDKjMzAS6KKzVmkz6EtSahuvvM9Gw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gD5PYaJuk93AWnTuR+Cr5t9OiDdEveuOMgQVwxSA0Mwhhgjfdq2isXnIiNsz0ZQMX
         9mElXtzSvxaqJ+BOufQ+kbKLo1+RY+kvN15OSpVRzAoAKgJgJ7ckkP1q0/Ca93m7hK
         PkGCAN61Cd17TZWuX4wbITuw6kvd3IY5+kHGNOXXSY1RV7lq21JbKJc49RW735hfN6
         rZYrQ+0iHcyL2EI/kBBMFQOt8SDvKrDHICRPXF1NaU8Xwht2/5bywQTmkbDhp2wF/+
         8/wQAwQjFSjrAfjLLqfoLHJ++5EAZHL2ZdmjVsXupS+VW0XPMEB28YfoxtxwSa6tCp
         BtOcytEGd+nFg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, quic_namajain@quicinc.com,
        konrad.dybcio@somainline.org
Cc:     quic_mojha@quicinc.com, quic_shashim@quicinc.com,
        linux-arm-msm@vger.kernel.org, quic_pkondeti@quicinc.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: socinfo: Add support for new fields in revision 16
Date:   Thu, 29 Dec 2022 11:49:12 -0600
Message-Id: <167233614958.1102610.10357476169515943708.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221125103533.2960-1-quic_namajain@quicinc.com>
References: <20221125103533.2960-1-quic_namajain@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Nov 2022 16:05:33 +0530, Naman Jain wrote:
> Add support for new fields coming with socinfo structure under v16 to get
> SKU information, product code and name and type of different parts present
> in the SoC. Also, add debugfs nodes to read feature and product codes to
> allow user to get SKU and other SoC details. Support for SoC parts name
> and type parsing will be added separately. Details of fields added:
> * feature_code: mapped to qcom internal and external SKU IDs
> * pcode: product code
> * npartnamemap_offset: parts name map array offset from socinfo base ptr
> * nnum_partname_mapping: number of part mappings
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: socinfo: Add support for new fields in revision 16
      commit: f02a537357a61e7892587c0f3455f8295cc9075c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
