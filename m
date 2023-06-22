Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3BD73A98B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 22:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjFVUeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 16:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjFVUeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 16:34:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC8FE9;
        Thu, 22 Jun 2023 13:34:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96F0E618EC;
        Thu, 22 Jun 2023 20:34:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 631A9C433CB;
        Thu, 22 Jun 2023 20:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687466053;
        bh=/jrzo23xohw0vOq31QrW3E4pCIODhVSB7kAOkjyOfmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mr59f+XetIsEv2vcmPh6au36GSgtM2a39S4Q6YyBcjAK6WEvfEP254zY4xjt09Bor
         5NE1BApKq0EoZZYSfjqfI+PDxh/F0qxM2iBmSzVob+cqeTlx64CuvQXkU4Sn4TPQtK
         b9RlcOqaFChm5+9PT3oHu3xVxudPdmyZ37eHnDbKiVTfBAu7tiVETes5ldRGkqxgIe
         drVSyECFEMdFuKwNoUcOIQhdbnIAvf00vP4uJamdAw5Z35F/xsd1rfOZEns3Gc/zIW
         YzOeEKwvJYm/HRqXCo0vVQ8srnqvAs4v6GTBSGZ0oUb5rg2/RyKX2pxqVirPUTy5wr
         rLZQrun8iACEg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] SC8280XP clock runtime pm
Date:   Thu, 22 Jun 2023 13:38:11 -0700
Message-ID: <168746628695.107789.3465009246870780002.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619-topic-sc8280xp-clk-rpm-v1-0-1e5e1064cdb2@linaro.org>
References: <20230619-topic-sc8280xp-clk-rpm-v1-0-1e5e1064cdb2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Jun 2023 18:13:16 +0200, Konrad Dybcio wrote:
> Keeping power domains always enabled hinders power efficiency. Add runtime
> PM to 8280 clock controllers to prevent that.
> 
> 

Applied, thanks!

[1/2] clk: qcom: gpucc-sc8280xp: Add runtime PM
      commit: 9bbcb892a7cd06c8156e6de211a8d7d45ee48086
[2/2] clk: qcom: gcc-sc8280xp: Add runtime PM
      commit: 2a541abd98370f9931c889c187eef7458720b57b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
