Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD24071F135
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 19:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjFARzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 13:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjFARzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 13:55:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4544713D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 10:55:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB7946487E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 17:55:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE54C433EF;
        Thu,  1 Jun 2023 17:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685642146;
        bh=gyEyxP4Zr3aodhX38TOCuaDdFGMcSxCu2jhPlr3IiIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cmcJixalqgdi/fSkQlheabF7n7HwrfFxGRp+CMN8kZjHRFgX0319Z53ryQnwekxEl
         yASqUt0/q+9NdaHCb+BnFqtvPSya8de6WY5dthS/QOVrOv65P85NEYaLo2O2GVl7eg
         yczB4yjqbkBHCyGnDAm3RnO2Fha7CziSG6pK71DM=
Date:   Thu, 1 Jun 2023 18:55:20 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [GIT PULL] w1: drivers for v6.5
Message-ID: <2023060109-amusable-crewless-3498@gregkh>
References: <20230601171214.1187837-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601171214.1187837-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 07:12:14PM +0200, Krzysztof Kozlowski wrote:
> Hi Greg,
> 
> My first W1-bus drivers pull.  I collected current and ~1.5 year old patches
> from the list.
> 
> The git tag for pull is signed with my usual key which you can get
> from kernel.org pgp keys repo: keys/1B93437D3B41629B.asc
> 
> Best regards,
> Krzysztof
> 
> 
> The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:
> 
>   Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-w1.git tags/w1-drv-6.5

Looks good, pulled and pushed out, thanks.

greg k-h
