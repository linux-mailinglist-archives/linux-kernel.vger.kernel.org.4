Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0013B704365
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 04:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjEPC04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 22:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjEPC0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 22:26:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480A355B8;
        Mon, 15 May 2023 19:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=GnugNPutPlVuYeEKQjN7ib4ukmX05TpR35f6nxJ8cQM=; b=v5c333hYJNg1DOmWuMJELbufQs
        dO67D9KA6WT9XJwtAS2pFU8SsADR8cPgDkHXgLM4OTElZh3uvzLTjxk39K5CWvZZHzkBhEoLbEnhA
        pTYAhBKOT/vNSvP5yAWOv3NnvDMtmYrjkTMewBW8RFahTYF0W0DTUNr6/lx3HHDYun/vYPHeJnSN4
        cbLZQNCA3cHoPILDA/zMHLmwwMmwRLI8/7zVfg98OmjDXCJw6HbL7CZlq9s3CweGE1pYZLf1LTNUj
        c91M61MZYDqU7p0JfjwcypW2F/xjIDgyGM++CfrdXi5dUHds0CvfVYd4K8oaNa0WXS7YWBWLeDfEk
        J99iq2nA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pykOr-0048Pb-27;
        Tue, 16 May 2023 02:26:53 +0000
Message-ID: <f9e201cb-71b9-ee38-5fa6-e96dd98cd1a9@infradead.org>
Date:   Mon, 15 May 2023 19:26:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: linux-next: Tree for May 15 (drivers/macintosh/ams/ams-core.c)
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <20230515141235.0777c631@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230515141235.0777c631@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/14/23 21:12, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20230512:
> 

../drivers/macintosh/ams/ams-core.c: In function 'ams_init':
../drivers/macintosh/ams/ams-core.c:181:29: warning: unused variable 'np' [-Wunused-variable]
  181 |         struct device_node *np;
      |                             ^~


-- 
~Randy
