Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEDE57104E5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240080AbjEYE5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233778AbjEYEzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:55:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638BE19A8;
        Wed, 24 May 2023 21:52:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 059D7642B1;
        Thu, 25 May 2023 04:51:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D09DC433A1;
        Thu, 25 May 2023 04:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990315;
        bh=vqN46RB7k0amDHt8lyz2DGuXkSMhCOcUBmnoXjeu9Gk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HgYj11H+SrBzPjJk7gdM7kulvt+wzB9LkdFuXtHr4uaFyRXnhQ1Axpzya2knYhi5r
         ppX/avnvcymQdW8COD3QLuq/U12xQiIsbpSrSl7uDJ6YA2XllIVvFtBBEQJH1nHAxD
         SKO0FPj3Ax725dHl8WvlEAheX+MBbnrpRZjQqI5HfyiUunMBHt2nUHI+aNoOJewxS/
         ItjSX8Un9o234EKSktpeatVsH1psOOysHJ0wahzgjY5EmGNXBbkH0DP5v8jMWmLIpp
         Cl+XF0snhlCGjECWEW9rOPvr39KRhgEfUHiIBGz9cRQA2CcZD4tKPF5v3RPuiO6H8S
         kaaLLak6bv2fw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>,
        linux-arm-msm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>
Subject: Re: (subset) [PATCH v6 1/1] soc: qcom: mdt_loader: Enhance split binary detection
Date:   Wed, 24 May 2023 21:54:33 -0700
Message-Id: <168499048178.3998961.10672158686017676650.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230509001821.24010-1-quic_gokukris@quicinc.com>
References: <20230509001821.24010-1-quic_gokukris@quicinc.com>
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

On Mon, 8 May 2023 17:18:21 -0700, Gokul krishna Krishnakumar wrote:
> It may be that the offset of the first program header lies inside the mdt's
> filesize, in this case the loader would incorrectly assume that the bins
> were not split and in this scenario the firmware authentication fails.
> This change updates the logic used by the mdt loader to understand whether
> the firmware images are split or not. It figures this out by checking if
> each programs header's segment lies within the file or not.
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: mdt_loader: Enhance split binary detection
      commit: 210d12c8197a551caa2979be421aa42381156aec

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
