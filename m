Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0EC4611144
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 14:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiJ1MZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 08:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiJ1MZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 08:25:34 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBA98769F;
        Fri, 28 Oct 2022 05:25:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 07DB1CE2B02;
        Fri, 28 Oct 2022 12:25:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0477C433C1;
        Fri, 28 Oct 2022 12:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666959926;
        bh=yXi+zNZmws/VEotmbHPHeWJ+f72XDWuCWYjRYk20mS4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eb3MGwY6t3ySKB2k95Eef1hQWuz+o60kW9FxbqyUu0flihGpaRL58YhD/OCvQNV/Q
         dgfKoIENpT25G4j3pMvgBC0hKf2EcT3fo1krfJ4d7px5vtPIKO7zAkrHXMszYV50ck
         2LoJk/jB+f7mEErfzQVHh9TXMc85+fkMyhi1BEJln5RwPJk4ar7FryVOouSOQoZnCU
         +o9LDVbDgPbEFDUJxdQ0FwEVvQXeHuj45/DRzOJAEU7LF/3085pgassDMf5c6c8UjG
         AqtifNKM0+8DvEr4UQPZ8aSlgJgll3f/nfo7J/RLyK58vZffjIe2vAkvM5YsoAuz+w
         CihXOSVDZRZyw==
Date:   Fri, 28 Oct 2022 17:55:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/20] phy: qcom-qmp: further prep fixes and cleanups
 (set 3)
Message-ID: <Y1vKMonBPePdNpyx@matsya>
References: <20221012084846.24003-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221012084846.24003-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-10-22, 10:48, Johan Hovold wrote:
> Here's the next batch of QMP fixes and cleanups in preparation for
> adding support for SC8280XP and its four-lane PCIe PHYs.

Applied, thanks

-- 
~Vinod
