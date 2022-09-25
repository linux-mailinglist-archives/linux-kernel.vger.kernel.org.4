Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3245E94C4
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 19:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbiIYRTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 13:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiIYRS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 13:18:57 -0400
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A5B2A958;
        Sun, 25 Sep 2022 10:18:56 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 5C1DE580360;
        Sun, 25 Sep 2022 13:18:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sun, 25 Sep 2022 13:18:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1664126336; x=
        1664126936; bh=HCqk0OG1lzClXrvZZ9Tb9QvrGSh6HBbWcykRR6Kk2Y0=; b=j
        KBmfVqDPZ+dfemNUlGd6XVoSgMVl8CnI/ZSB7rJd5mBjyncEiNfH7p/yuoRPaX8O
        qDRHIIRbtSiBj7Y7xEiF+GpDZm87pLwpC7J61Ip4t/aPzdrEJmD9nTQFw11Aq1Ng
        oX8LXApSwg6qgFtZq45d4Yt5pmPddsOwIp3AL+v2sc/bhT7lv8snzvBFc2MNKJKO
        AiSsMAPUGvMnXiKjo0MgZ+9I9kBacSx0m+65/gt2KgXnrCLwUh7VIr+c5r/8TTcA
        UfWLXqXfEfPWmz3Am/eMUV1VQnzbyru0N75Ku5WmJ9yx1YcpqVd0iIaTWt0rFWnu
        FnUOmyJIKgB1yaiVgoUBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=i78e14604.fm2; t=
        1664126336; x=1664126936; bh=HCqk0OG1lzClXrvZZ9Tb9QvrGSh6HBbWcyk
        RR6Kk2Y0=; b=sSOD1vtHJprAY2Qjb0g9c/PvHHFwf0rAB+JEXvjUv3LZatIEPh4
        bx56Nj8yGGj4IOZXHIjZINs2TJonpr6SxcUGk87Umld40XgLzS+/BCADs8/0Lt14
        GwBl0Mb39v6XiqsqPmw506zgu9JhdeSBliJlvXurE3P59BZgk9zZ5BC3LqR7ExV/
        piwyrLCdouMXxgjQoRNbrnMbsTzoSHhUrJG/norF67Esy8Al6zxYR8VfeiYid/Bf
        SnkosB+ww9vUDTl65VuiFn2qlaJtPilOxVu3DhHa5EfgGCQgcGhqZelpQwRSxjTj
        yO6dg67qsGPrSvs32J9qOfZ2eoa0c1IjG8A==
X-ME-Sender: <xms:f40wY62ZtsA3BUdqo9I_D0nvxy6K1P-1cvqZSH-LCrrNmN73QbBIOw>
    <xme:f40wY9H4QhWIe7XTkG1TRfgF4f_aYjmnOjSx766tL1NzGAqngVnWHaX-GE0_RGUks
    LunqKe0tHZxce7XAiA>
X-ME-Received: <xmr:f40wYy4PHM8JVdttCWj-L7M_rcBAozo7NESmqzMA5gfSamoMOApBOxZ0AcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeegtddguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepvfih
    lhgvrhcujfhitghkshcuoegtohguvgesthihhhhitghkshdrtghomheqnecuggftrfgrth
    htvghrnhepgefhieeuheefkeetffefffekjefhgfefiedvveeiuedugfeufeefvdeihfeh
    ieevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptg
    houggvsehthihhihgtkhhsrdgtohhm
X-ME-Proxy: <xmx:f40wY7024YsyLwdLN4gcLuAuRYKjmY7kSXbJ8g8Zr00gZ6G4n6LGcw>
    <xmx:f40wY9HgkX41jXBc4Dq3OGaelAHgYarD12Q6KCaUSXXXlATWPFgkNA>
    <xmx:f40wY08bq_MBPGfhFRGBYXvXsptCKzOb5psdr1w5QygfAR857hw-tg>
    <xmx:gI0wY8eIuES_HKeMY0xwh_n5shDMMz_8F--2jWRETO_90l3McgjoN0bc3Lw>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 25 Sep 2022 13:18:54 -0400 (EDT)
Date:   Sun, 25 Sep 2022 12:18:52 -0500
From:   Tyler Hicks <code@tyhicks.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@digitalocean.com>,
        Amir Goldstein <amir73il@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Theodore Ts'o <tytso@mit.edu>,
        Muchun Song <songmuchun@bytedance.com>,
        ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [RESEND PATCH] ecryptfs: Replace kmap() with kmap_local_page()
Message-ID: <20220925171852.GD59018@sequoia>
References: <20220901160704.25701-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220901160704.25701-1-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-01 18:07:04, Fabio M. De Francesco wrote:
> The use of kmap() is being deprecated in favor of kmap_local_page().
> 
> There are two main problems with kmap(): (1) It comes with an overhead as
> the mapping space is restricted and protected by a global lock for
> synchronization and (2) it also requires global TLB invalidation when the
> kmap’s pool wraps and it might block when the mapping space is fully
> utilized until a slot becomes available.
> 
> With kmap_local_page() the mappings are per thread, CPU local, can take
> page faults, and can be called from any context (including interrupts).
> It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
> the tasks can be preempted and, when they are scheduled to run again, the
> kernel virtual addresses are restored and still valid.
> 
> Since its use in fs/ecryptfs is safe everywhere, it should be preferred.
> 
> Therefore, replace kmap() with kmap_local_page() in fs/ecryptfs.
> 
> Cc: "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> 
> I'm resending this patch because some recipients were missing in the
> previous submission. In the meantime I'm also adding some more information
> in the commit message. There are no changes in the code.

Thanks for the additional information, Fabio. I've tested and applied
it.

Tyler

> 
>  fs/ecryptfs/crypto.c     | 8 ++++----
>  fs/ecryptfs/read_write.c | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
> index e3f5d7f3c8a0..03263ebcccc6 100644
> --- a/fs/ecryptfs/crypto.c
> +++ b/fs/ecryptfs/crypto.c
> @@ -465,10 +465,10 @@ int ecryptfs_encrypt_page(struct page *page)
>  	}
>  
>  	lower_offset = lower_offset_for_page(crypt_stat, page);
> -	enc_extent_virt = kmap(enc_extent_page);
> +	enc_extent_virt = kmap_local_page(enc_extent_page);
>  	rc = ecryptfs_write_lower(ecryptfs_inode, enc_extent_virt, lower_offset,
>  				  PAGE_SIZE);
> -	kunmap(enc_extent_page);
> +	kunmap_local(enc_extent_virt);
>  	if (rc < 0) {
>  		ecryptfs_printk(KERN_ERR,
>  			"Error attempting to write lower page; rc = [%d]\n",
> @@ -514,10 +514,10 @@ int ecryptfs_decrypt_page(struct page *page)
>  	BUG_ON(!(crypt_stat->flags & ECRYPTFS_ENCRYPTED));
>  
>  	lower_offset = lower_offset_for_page(crypt_stat, page);
> -	page_virt = kmap(page);
> +	page_virt = kmap_local_page(page);
>  	rc = ecryptfs_read_lower(page_virt, lower_offset, PAGE_SIZE,
>  				 ecryptfs_inode);
> -	kunmap(page);
> +	kunmap_local(page_virt);
>  	if (rc < 0) {
>  		ecryptfs_printk(KERN_ERR,
>  			"Error attempting to read lower page; rc = [%d]\n",
> diff --git a/fs/ecryptfs/read_write.c b/fs/ecryptfs/read_write.c
> index 60bdcaddcbe5..5edf027c8359 100644
> --- a/fs/ecryptfs/read_write.c
> +++ b/fs/ecryptfs/read_write.c
> @@ -64,11 +64,11 @@ int ecryptfs_write_lower_page_segment(struct inode *ecryptfs_inode,
>  
>  	offset = ((((loff_t)page_for_lower->index) << PAGE_SHIFT)
>  		  + offset_in_page);
> -	virt = kmap(page_for_lower);
> +	virt = kmap_local_page(page_for_lower);
>  	rc = ecryptfs_write_lower(ecryptfs_inode, virt, offset, size);
>  	if (rc > 0)
>  		rc = 0;
> -	kunmap(page_for_lower);
> +	kunmap_local(virt);
>  	return rc;
>  }
>  
> @@ -253,11 +253,11 @@ int ecryptfs_read_lower_page_segment(struct page *page_for_ecryptfs,
>  	int rc;
>  
>  	offset = ((((loff_t)page_index) << PAGE_SHIFT) + offset_in_page);
> -	virt = kmap(page_for_ecryptfs);
> +	virt = kmap_local_page(page_for_ecryptfs);
>  	rc = ecryptfs_read_lower(virt, offset, size, ecryptfs_inode);
>  	if (rc > 0)
>  		rc = 0;
> -	kunmap(page_for_ecryptfs);
> +	kunmap_local(virt);
>  	flush_dcache_page(page_for_ecryptfs);
>  	return rc;
>  }
> -- 
> 2.37.2
> 
