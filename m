Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003A65B7772
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 19:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbiIMRMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 13:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbiIMRLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 13:11:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F3D95696;
        Tue, 13 Sep 2022 09:00:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 879A9B80E22;
        Tue, 13 Sep 2022 14:53:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D273C433C1;
        Tue, 13 Sep 2022 14:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663080836;
        bh=zd5RQfhiDzh7kjG/uuLjr8XNlVS9sWYPTYLzY0MfS/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i7DTEmcNaDYGVj42mt6D4YfGWi4pd2+N8SKaiXzmSjR7q9ST9O2qQKeS4chgEwqCc
         yIMBN044B1rTe0MiLz+c5/JCja0AqNFZ7iWAYA1JfOeKPpQt71Uk4dFWZlbdwe7Kn6
         sGdh7EDxAn3XQ+d2pMMl4Su4B+/iali245EfdOhJcAsWxavptAr/lxzQaOim03BZ3g
         Un7E9ly9Ndiao3f9tTQ62VPlwvAJC/ZZZlhuA4SssVCmSKZ1oWwZaboGZG6qh3YGHo
         9MUmHzvkstTYj/ehITJN6Pxl84xhK2lBbQozXnt4MjjrW2WQdBXL2j/mlQn/GKO6A+
         exUSLn3XSWlFQ==
Date:   Tue, 13 Sep 2022 20:23:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] phy: qcom-qmp-pcie: shorten function prefixes
Message-ID: <YyCZgHx66V3rhv7u@matsya>
References: <20220906074550.4383-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906074550.4383-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-09-22, 09:45, Johan Hovold wrote:
> The QMP PHY driver function prefixes have become unnecessarily long
> (e.g. after the recent driver split) and hurt readability.
> 
> This series shortens the "qcom_qmp_phy_pcie" prefix to "qmp_pcie" (QMP
> likely stands for "Qualcomm Multi PHY" or similar anyway) and clean up
> the code somewhat.

Applied, thanks

> 
> Once merged I can do the same conversion of the other four QMP drivers.

Patches welcome!

-- 
~Vinod
