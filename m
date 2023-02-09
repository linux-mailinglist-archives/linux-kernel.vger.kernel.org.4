Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB346912CA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 22:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjBIVuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 16:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjBIVup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 16:50:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDF860E7B;
        Thu,  9 Feb 2023 13:50:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 040E56187F;
        Thu,  9 Feb 2023 21:50:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA15C4339C;
        Thu,  9 Feb 2023 21:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675979443;
        bh=tuk1PM1WHMjxdBlr0beL/zkj3i8hL7PyqoTOxllce+0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=NnIfqqN7nfF/xsWdi9iF5LQ70RRhm2fcKoOMbzXVnSBs5abYDyiWuwA0rJeiTpamn
         4LUqKW+5xyfdOE6Ko9F54hKxmjNsYjPQtZ1F0SxDdebabrfOIQJX4bFnz1845he7QA
         oT5PKXEwtlUfYREESKqg/yorElfq2hPbzEfLuDsz+GLbS9dltoNX3N38d9epBSJuQO
         eQvYu5dAzZSDvIeqsSKaJCF+BiSBcp9J2kOGXwEEm4QlY97T0+U3zJbB6vsIWkYX18
         TFJGaTMTBnG2JF1qKqtkeluG/+Gf3bkWBoCNG45CiBPD3GG8QeQxusGY4z55CMeNq/
         u+FIr+xYMQlvA==
Message-ID: <80ad3bea4749243f4ba4b535889a0ad9.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1675318653-28352-6-git-send-email-quic_srivasam@quicinc.com>
References: <1675318653-28352-1-git-send-email-quic_srivasam@quicinc.com> <1675318653-28352-6-git-send-email-quic_srivasam@quicinc.com>
Subject: Re: [PATCH v7 5/5] clk: qcom: lpassaudiocc-sc7280: Skip lpass_aon_cc_pll config
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, broonie@kernel.org,
        konrad.dybcio@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        quic_plai@quicinc.com, quic_rohkumar@quicinc.com,
        robh+dt@kernel.org, swboyd@chromium.org
Date:   Thu, 09 Feb 2023 13:50:41 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2023-02-01 22:17:33)
> Skip lpass_aon_cc_pll configuration for ADSP based platforms
> based on qcom,adsp-pil-mode property.
> This is to avoid ADSP out of reset fail.
>=20
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Tested-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
