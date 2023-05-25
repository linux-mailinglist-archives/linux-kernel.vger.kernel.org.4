Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF267104D4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239530AbjEYE4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239687AbjEYEy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:54:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B891991;
        Wed, 24 May 2023 21:52:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 784C2641A7;
        Thu, 25 May 2023 04:51:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE0CC433A1;
        Thu, 25 May 2023 04:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990311;
        bh=apMkKvYFN8ljtEvzQD2/s1gcQz71bSZdKPxky0bwPP4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ix3bvv/hWQ+OyvUIDqWxCGfNVMPkBlyrzZBDPIyQMio8Xb536bAy8+2XwqHAubPXl
         oOy7vhVFjJGhrija84wL0xAU3S8fxPDeuohyfbCeJ56d2TK03K1twI/5WmGE/tfFcx
         8dLHkChi1UvgpXu2h3QWZUBYBjL2qiVYvu/9u8YTiTfSle4hgzGVX8OEDHrMJq6VOi
         2/z5CKD4ckM+f/rN6hOnE+FW7Hz6YXHRJ1HJ0LZVYUki9QkMyC80ROj9FA7d7MfHD5
         Qo3GyAFNV3ApbCnN6sQFeJlo9bo7QLtmnpVg665M6EIY0m0tOxg4tAsm08Qjl3WC7K
         AeTU87GEnmVDQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Min-Hua Chen <minhuadotchen@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: rpmpd: use correct __le32 type
Date:   Wed, 24 May 2023 21:54:30 -0700
Message-Id: <168499048181.3998961.5413274863907546712.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230522160757.284165-1-minhuadotchen@gmail.com>
References: <20230522160757.284165-1-minhuadotchen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2023 00:07:56 +0800, Min-Hua Chen wrote:
> Use cpu_to_le32 to cast constants to __le32 before comparing
> them with __le32 type pd->key. This fixes the following sparse
> warnings:
> 
> drivers/soc/qcom/rpmpd.c:895:31: sparse: warning: restricted __le32 degrades to integer
> drivers/soc/qcom/rpmpd.c:896:15: sparse: warning: restricted __le32 degrades to integer
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: rpmpd: use correct __le32 type
      commit: 4b819e7e89fedc90150a78152bfa6e6e3534e64b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
