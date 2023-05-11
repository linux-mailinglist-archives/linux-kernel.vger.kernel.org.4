Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94C36FE844
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 02:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236236AbjEKABS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 20:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjEKABQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 20:01:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A2730F1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 17:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:Subject:From:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=vvM4rHyiKjQ5bQvsVQvlvuqd9/HFogACk90SZ5OMxTc=; b=0bQBSQ5HESyH5hgRoaTDmbPA7v
        9MfBObsSWNF3vBxAYheOnEyTN0aJJDOtB2zGvyAFqIT9ID6xQq94puIX/6FhP03nLVN8jjhUSNrrn
        Bt+5Jkt1xrFq2uh5YANeOMUSIZGjp4CMCDuAotiH8aSReUkz4S2PG2AOLpRFtoSoNLc6JDn07UyMc
        Fti2DfebSb5OQ6vKxSFCMPA3Ci0mU07IUKg9Be5vFQVhmgHyv+Dk9sDPRgXpDmfXbdtdnmCeC/b6X
        Tc/eAVN7nw5N2bg79N7iqZvfIANdCmSQHGMXH3jvcL5gF58Zsyv/piO7q7YED4LvqYDrU04YiqkUF
        4DBuB0+Q==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pwtkA-007IWw-2a;
        Thu, 11 May 2023 00:01:14 +0000
Message-ID: <fb4fa92a-eabe-10b8-fffd-7ffc8a70404b@infradead.org>
Date:   Wed, 10 May 2023 17:01:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Content-Language: en-US
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Joe Perches <joe@perches.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [pseudo-PATCH] sort MAINTAINERS file
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please run scripts/parse-maintainers.pl to sort the MAINTAINERS file.

It has gained more than 100 out-of-order entries since it was last sorted.

BTW, running the script results in a MAINTAINERS.new file with 5 fewer bytes
than the MAINTAINERS file. This is due to one F: line being changed from
having spaces between F: and the filename to having one tab there instead.


Thanks.
-- 
~Randy
