Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DCA6110ED
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 14:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbiJ1MMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 08:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiJ1MMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 08:12:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AA01C3E5C;
        Fri, 28 Oct 2022 05:12:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A53B7B829B8;
        Fri, 28 Oct 2022 12:12:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED12C433C1;
        Fri, 28 Oct 2022 12:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666959163;
        bh=dDWfYoWl7qZ7zaxkIPBypox2awqiVXogm5AFCaIUe6g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YuZ8hycFeKhsDl047mwW+QXlUXjkGZx9ovC5AxOwWNVIWsu7VrKTESNPY095JDHya
         /4N4hoznpUOJ37LWYQweI+8z62C7xnQhkDBaVAYc0NPgwQopTuRd4DHb9CMJBB+DWu
         r9yXrtWlUlkBgdT2hrqZfLGlfVfgQ/3Tjz5cLRpe8IdiP0On+UIkhufOIQ6pRvofYN
         btbd+cGbm5oap0Dy77vN/mLQNLnOlQgJ9dkziMgzZm/A8+HS0NgfsQYRwu2BFm/R9P
         ilrlVdNlajRAIUyc6qZfDEtfz8Vo8gZF6Bp+7vVigv6208hnpzwuOL9H8ui0+2EziX
         VCyu0A0W3Lu5g==
Date:   Fri, 28 Oct 2022 17:42:39 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/14] phy: qcom-qmp: further prep cleanups
Message-ID: <Y1vHN5JnKMy6AN9i@matsya>
References: <20221012081241.18273-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221012081241.18273-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-10-22, 10:12, Johan Hovold wrote:
> Here's the next batch of QMP cleanups in preparation for adding support
> for SC8280XP and its four-lane PCIe PHYs.

Applied, thanks

-- 
~Vinod
