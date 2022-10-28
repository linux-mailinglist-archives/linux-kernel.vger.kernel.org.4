Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77756610FBD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 13:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiJ1Lbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 07:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiJ1Lbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 07:31:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E87ABD54;
        Fri, 28 Oct 2022 04:31:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3135D627CE;
        Fri, 28 Oct 2022 11:31:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71BBC433D6;
        Fri, 28 Oct 2022 11:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666956701;
        bh=q0lnOSum//LwPg46x156hM2PbLCHWNsC+B5nIs59ccc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UTDCBsjLxk2mBDSl9PMp0X7zrsOmWygSgZcmhoghuTaozDLTyHgrdMh8K8wMiRwH7
         qrs07wSVDSalptihHLru5/QAQeE/o4hF52Ja96bkszWU0cvQ/lx96xbWgZjNZyyl74
         Fe36q1Hct1Z/MWaMzHWr7eqGYbx4fhBd64RAD54s/3n2Yo1QS31hf4kZMKueBvYc2f
         fWn2t8+co9TU53T2z34avoWwtKXAf670oK+dAgB7feY37L/2YJiFADoWI4pSCcHRx6
         POCEDrBTv5gu6xEG4gHLteIIgIV/DGJ3yMDNwLGKneH+SGPKyFdc9X1AHtSlOQLAkh
         Yw3ovsvj0kZTg==
Date:   Fri, 28 Oct 2022 17:01:36 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     yung-chuan.liao@linux.intel.com, andersson@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 0/6] soundwire: qcom: fixes and support for v1.7
Message-ID: <Y1u9mGL5eELZT3Dw@matsya>
References: <20221026110210.6575-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026110210.6575-1-srinivas.kandagatla@linaro.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-10-22, 12:02, Srinivas Kandagatla wrote:
> This patchset has 2 fixes around fifo handling adds support
> for v1.7.0 controller found in SM8450 SoCs. Also a patch to
> make reset optional for v1.6 as this is not required for sc8280xp.

Applied, thanks

-- 
~Vinod
