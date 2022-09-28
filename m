Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F005EE3BE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 20:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbiI1SAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 14:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234727AbiI1R7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 13:59:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4711F43E51
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:59:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A30FDB821B6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 17:59:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE1BC433C1;
        Wed, 28 Sep 2022 17:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664387984;
        bh=TLuv2+Flbr7K2dwKymjv0q3q32sR+IjJMe9UMLxknVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LhOOLkhWjeMVXx7ej4XGMqO8PW4RLHb/cN0FYg2F1A1heIudnavrwpBEZ+lT8Y9+Y
         p8rojsx9gJfyfCJOCkYKpQWw+N7fUo0Z8m1Ge7s9YzvxbDyLcPdrRrdw/0wpNdMtzr
         Kj7f3fziu12uwFx645sL2TMz/+3iSrrA/3EJrcy2f1gu6ygKN7Uye9E8EBydRvkwpK
         DxsQl1HIOrB/dfp6OWIe22UldtK1ubjToWQe5GlcksHiXlxOfG2fMAGSFBxB3tO3IE
         tPfGPtSzhTH79ApmeDL/OBG2N+WjlJozWTIAh7wJGh/H8wxdPcIgxxJWXsUvSUARz3
         FCmrgVWc7KOJg==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     damon@lists.linux.dev, linux-damon@amazon.com,
        linux-damon-trial@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: DAMON Beer/Coffee/Tea chat series
Date:   Wed, 28 Sep 2022 17:59:42 +0000
Message-Id: <20220928175942.168657-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220810225102.124459-1-sj@kernel.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, 10 Aug 2022 22:51:02 +0000 SeongJae Park <sj@kernel.org> wrote:

> Hello,
> 
> 
> In short, I'd like to start an open, regular, and informal virtual bi-weekly
> meeting series for DAMON community.

The next instance of the series was scheduled to 2022-10-04 (Tue) 09:00 PDT
(https://meet.google.com/ndx-evoc-gbu), but I now reschedule it 30 minutes
after, due to a conflict.  So, the next instance will be:

    2022-10-04 (Tue) 09:30 PDT (https://meet.google.com/ndx-evoc-gbu)

I also updated the Google Doc for the agendas:
https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing

Looking forward to meet you!


Thanks,
SJ

[...]
