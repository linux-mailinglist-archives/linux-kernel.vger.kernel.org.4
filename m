Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34CB6BC182
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbjCOXfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbjCOXfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:35:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D599BA17F7;
        Wed, 15 Mar 2023 16:34:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAA3161EB0;
        Wed, 15 Mar 2023 23:32:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679E0C433EF;
        Wed, 15 Mar 2023 23:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678923172;
        bh=7mM/1jbUaMBx1fplfRcx8nVmkPYBxzHaUaXdFxqx4FQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rotv1d9fnf362cjtb5vj8HiZKtANcCw1Sf1Fx8d1kXaPzZ4CyHss0KkbNarj/BXwD
         LBHMlxkJguvoHI195HFOLIdEx/6KN6fiV+FvzmfU7eJlEhEPAFwMvvdNSpCKIhW0iF
         SCV8GVoQiCkom4c4f6rZNVk/SM1hd6pL1YP6iBJzBq8L6eYnV6FFejDMo+LbxBVpTU
         3FXISiXvdlUlF+FmjPwfApj5JC/jh32L8e8TBFJNpA/TPN98Ogw8mXYW2ihDIzt6v2
         q1oMVtsPTL5SwJ5ujfuLIMs+Zj6/zYwYPhnW4Un0FjfpZHrMimjzhTfB7wx3RZJY5t
         HQF3tN9jlHDWA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     broonie@kernel.org, marcel.ziswiler@toradex.com, agross@kernel.org,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        devicetree@vger.kernel.org, will@kernel.org,
        Poovendhan Selvaraj <quic_poovendh@quicinc.com>,
        dmitry.baryshkov@linaro.org, linux-arm-msm@vger.kernel.org,
        robimarko@gmail.com, robh+dt@kernel.org, lee@kernel.org,
        nfraprado@collabora.com, shawnguo@kernel.org,
        konrad.dybcio@linaro.org, quic_gurus@quicinc.com, arnd@arndb.de,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_kathirav@quicinc.com, quic_anusha@quicinc.com,
        quic_sjaganat@quicinc.com, quic_arajkuma@quicinc.com,
        quic_devipriy@quicinc.com
Subject: Re: (subset) [PATCH V5 0/5] Enable crashdump collection support for IPQ9574
Date:   Wed, 15 Mar 2023 16:35:22 -0700
Message-Id: <167892332568.4030021.4457316512942679175.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230216120012.28357-1-quic_poovendh@quicinc.com>
References: <20230216120012.28357-1-quic_poovendh@quicinc.com>
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

On Thu, 16 Feb 2023 17:30:07 +0530, Poovendhan Selvaraj wrote:
> Crashdump collection is enabled based on the DLOAD bit in the TCSR register.
> This bit is set during bootup and clearing during shutdown. During crash,
> dload bit is not cleared, due to which uboot starts crashdump collection.
> 
> Enable the support for download mode to collect the crashdumps if
> system crashes, to debug crashes extensively.
> 
> [...]

Applied, thanks!

[1/5] dt-bindings: scm: Add compatible for IPQ9574
      commit: 81ac39144bf65c5f8ee00e61308fe1f3399b347c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
