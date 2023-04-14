Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291206E18E4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 02:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjDNAQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 20:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDNAQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 20:16:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BEA10F;
        Thu, 13 Apr 2023 17:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rI+r3OdYH3zPiiWkr3ZC694K7fpZTPe7EnjL7E4QBH8=; b=aRuwtBhr/GH4fi5cM5dHtuMa76
        7HcOXXy5p9/BjgGJ5WFymAkUIgIhqAHU113QSWRl8MrCdgGn3c1ZhitiYC4P0CpbZD0yAYFvFl6QE
        eGtoieengRJJf1gUZvb54ktApGJmTAn3LHyIRgz/Ciw3/WyDky1/C8ZoT6LzEIEhlKB1JVSWCvkIN
        yjKBumMCxkGZ3kr5WqJvBd3eCB4R+WHCASHMD75wzGvDW3Fy9Nl9oIvVg8+p3dUbcQLakMJJsYmW9
        DSzLsR1p5D4Kr1k+xabDmtgKaTcmbzLkUX1BK94PPALIIiasj8Nkyw5bhbxS8ws/essq9EDlz+g4h
        hKA7C8dQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pn76z-007avv-1A;
        Fri, 14 Apr 2023 00:16:21 +0000
Date:   Thu, 13 Apr 2023 17:16:21 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH 0/3] Modify is_arm_mapping_symbol() related code
Message-ID: <ZDibVa6qARyAOyne@bombadil.infradead.org>
References: <1680254153-14582-1-git-send-email-yangtiezhu@loongson.cn>
 <ca51bd24-77de-54ed-c263-3eadd9c07fba@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca51bd24-77de-54ed-c263-3eadd9c07fba@loongson.cn>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 03:37:27PM +0800, Tiezhu Yang wrote:
> Hi Luis,
> 
> Are you OK with this change?
> Any comments will be much appreciated.
> 
> https://lore.kernel.org/lkml/1680254153-14582-1-git-send-email-yangtiezhu@loongson.cn/
> 

Yes applied to modules-next and pushed, thanks!

  Luis
