Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596EC72973B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 12:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238074AbjFIKnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 06:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239376AbjFIKm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 06:42:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42C3184;
        Fri,  9 Jun 2023 03:41:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61A38656B7;
        Fri,  9 Jun 2023 10:41:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C504C433EF;
        Fri,  9 Jun 2023 10:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686307284;
        bh=Vw7CAMy9UVWseFZvxo+YJeqHqBluD3O8iCFNtoJ+/Lw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=gLav8swb/qDgwQGtv+ecW6nAN5Lr1tiZpReIxcgom90avPIEsLrjnpWKNL3I2w2cO
         5b+I40DAUW38K75Op0XQ38DRqtqkM2egWCgge9qZjUbV4NYkmI1UyeVoqUpE+tf8ht
         yZxZhfET8tP6DdQjoc3dS9eDNmpoVKmCEvQWdj8ozXXsFDoA3uBmAaW6Pfnf0t+9mg
         uQHZer+Xt3YnnVqPRN8h2EUmc5Yu8J7D/7pQDbDdyj9s94/wY/0HA8cNioskC6xA4F
         snNkcwSAxeX8wC/Rl6BGUldpTc4Sg8tV/df1XYnJMywVkWENghb1/XLKMlOk6A+ffn
         VSx+yVuxR/YjA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: Replace RX workqueues with kthreads
References: <20230609103651.313194-1-treapking@chromium.org>
Date:   Fri, 09 Jun 2023 13:41:17 +0300
In-Reply-To: <20230609103651.313194-1-treapking@chromium.org> (Pin-yen Lin's
        message of "Fri, 9 Jun 2023 18:35:01 +0800")
Message-ID: <87o7lohq9e.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pin-yen Lin <treapking@chromium.org> writes:

> This improves the RX throughput likely by better locality for the work
> loads.
>
> We tested this patch on Mediatek MT8173 Chromebooks, and it shows ~80%
> Rx throughput improvement on high data rate test cases.

80%? That's huge from so small patch like this! What are the before and
after numbers?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
