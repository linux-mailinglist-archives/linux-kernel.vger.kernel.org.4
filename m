Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4086585C0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 19:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbiL1STR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 13:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbiL1SSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 13:18:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DB213D12;
        Wed, 28 Dec 2022 10:18:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EB7661582;
        Wed, 28 Dec 2022 18:18:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33395C433F0;
        Wed, 28 Dec 2022 18:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672251522;
        bh=UU0WabvbvRFQxUGPwVgO/GOHLKbQ3MjvzaolAISulfU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=fTG7vLU4DrdzNJeupVN3JWUZdw1GQdRXzb69a3GZzpeOEBX5oEEGBgBbPzR0buR0I
         qCZpyWjQmU4iNXtEp6uadNrRF2N9Fu/UxUxCH5VknSD1l2cet6oHkYY+6QkjknIC8Q
         SJVzcCgaMaaDr5kVR/f4AA5neohrvrr0+Pj7BltZ8hfK8KuppAiIaXpbNJmyXFSLQ4
         Z5HT2eiPQXyx4qVXI96R0qUsS4HG7fdnRgZAtnVIlaL64RycDSUo5LnjngWAGNHkK/
         tf/A8YbbN6O1BcaAQ/Ef90V76gwdRFoQG5IYJgGl9axoTXobS8VsgA6sOSaWJhKOlW
         doEfpIrQkoEag==
From:   Bjorn Andersson <andersson@kernel.org>
To:     srinivas.kandagatla@linaro.org, tiwai@suse.com,
        bgoswami@quicinc.com, judyhsiao@chromium.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, perex@perex.cz, krzysztof.kozlowski@linaro.org,
        devicetree@vger.kernel.org, swboyd@chromium.org,
        quic_plai@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_rohkumar@quicinc.com, quic_srivasam@quicinc.com,
        broonie@kernel.org, agross@kernel.org
Subject: Re: [PATCH v10 0/7] Update ADSP pil loader for SC7280 platform
Date:   Wed, 28 Dec 2022 12:18:31 -0600
Message-Id: <167225151232.950465.18401673401717187905.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <1664368073-13659-1-git-send-email-quic_srivasam@quicinc.com>
References: <1664368073-13659-1-git-send-email-quic_srivasam@quicinc.com>
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

On Wed, 28 Sep 2022 17:57:46 +0530, Srinivasa Rao Mandadapu wrote:
> Update ADSP pil loader driver for SC7280 platforms.
> 
> Changes since V9:
> 	-- Add missing unevaluatedProperties in dt-bindings glink-edge.
> Changes since V8:
> 	-- Add glink-edge reference in dt-bindings.
> 	-- Remove redundant glinke-edge properties in dt-bindings.
> 	-- Make all reg propertioes as mandatory in dt-bindings.
> 	-- Add iommus property in dt-bindings.
> Changes since V7:
> 	-- Drop out of reset time out patch.
> 	-- Remove redundant clocks in dt bindings.
> 	-- Fix dt compilation error in dt bindings.
> Changes since V6:
> 	-- Update dt-bindings with glink-edge
> 	-- Add qcom,qmp property.
> 	-- Update parse firmware callback.
> 	-- Update commit message.
> 	-- Update smmu map and unmap function names.
> 	-- Revert adsp_ops const change.
> 	-- Move iommu check to within smmu map/unmap functions.
> Changes since V5:
> 	-- Remove adsp_rproc_unmap_smmu, adsp_of_unmap_smmu, adsp_of_map_smmu and
> 	   adsp_rproc_map_smmu functions.
> 	-- Remove find_loaded_rsc_table call back initialization.
> 	-- Rename adsp_sandbox_needed to has_iommu.
> 	-- Update parse_fw callback in rproc ops.
> 	-- Remove qcom,adsp-memory-regions property in dt-bindings.
> 	-- Change adsp binary extension name.
> Changes since V4:
> 	-- Update halt registers description in dt bindings.
> 	-- Update Memory sandboxing with proper APIs for resource
> 	   allocation and free.
> Changes since V3:
> 	-- Rename is_adsp_sb_needed to adsp_sandbox_needed.
> 	-- Update sc7280 compatible name entry in sorted order.
> 	-- Add smmu unmapping in error case and in adsp stop.
> 	-- Revert converting sdm845 dt bindings to generic and
> 	   create new dt bindings for sc7280.
> Changes since V2:
> 	-- Generated patch with -M flag.
> 	-- Add Clock property in dt bindings.
> 	-- Add qcom,adsp-memory-regions property.
> 	-- Add is_adsp_sb_needed flag instead of is_wpss.
> 	-- Initialize is_adsp_sb_needed flag.
> 	-- Remove empty proxy pds array.
> 	-- Replace platform_bus_type with adsp->dev->bus.
> 	-- Use API of_parse_phandle_with_args() instead of
> 	    of_parse_phandle_with_fixed_args().
> 	-- Replace adsp->is_wpss with adsp->is_adsp.
> 	-- Update error handling in adsp_start().
> Changes since V1:
> 	-- Change reg property maxItems to minItems and update description.
> 	-- Fix typo errors.
> 
> [...]

Applied, thanks!

[1/7] dt-bindings: remoteproc: qcom: Add SC7280 ADSP support
      commit: 8490a99586abd480d7139893f78c019790a58979
[2/7] remoteproc: qcom: Add flag in adsp private data structure
      commit: 272dca8d14c46d03c633756d150b1c48c1dcb594
[3/7] remoteproc: qcom: Add compatible name for SC7280 ADSP
      commit: 66cab0c5c3f9dae0213b9d02af03791b75565986
[4/7] remoteproc: qcom: Update rproc parse firmware callback
      commit: 48ab209c6f5f84a5adcd68e150dc0f614c8bfba7
[5/7] remoteproc: qcom: Replace hard coded values with macros
      commit: c36d6aa67932788ec04820ba65693ccd41b1042f
[6/7] remoteproc: qcom: Add efuse evb selection control
      commit: 9ece961916631aab81b9d9f8d9c2770d05548662
[7/7] remoteproc: qcom: Add support for memory sandbox
      commit: f22eedff28aff912bde7f8deabebd121cb64fae3

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
