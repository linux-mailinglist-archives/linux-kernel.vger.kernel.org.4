Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3305A6B0530
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjCHK7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 05:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjCHK64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:58:56 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912C49AFDB
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 02:58:50 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DEBFC1FE3D;
        Wed,  8 Mar 2023 10:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678273128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LCAfw6gZ22BA3KCRgOa8h5RexNoS/fKKCQLrt+0R00c=;
        b=d8LpWLDxMvAE42tUD5tt3BxLqadEeewL3CK1u5qY1fz7pCs+DdaHLMcbT4SKWNWi5IMqpw
        uMKSJ+O63xUj23/VHsGHSj+NGRIgaUeq2TWJfHZnlD3ondKQwRXAMfx3z6rRw9H+wxBIMc
        NJo/UL3PrgXUdp4RRKjg7sBAftecnYE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678273128;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LCAfw6gZ22BA3KCRgOa8h5RexNoS/fKKCQLrt+0R00c=;
        b=nZkEe64msf7Ncek7aYtUlKTfM3Nk5KTip3ddKJBrHqmlodyDIwpU5d7F8KKU2oevYwEj12
        3+bk564SEhgdzbDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B4B191348D;
        Wed,  8 Mar 2023 10:58:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NDPuKmhqCGQQbwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 08 Mar 2023 10:58:48 +0000
Message-ID: <9abef101-3a9b-0bdd-7139-ced7d5e28ebe@suse.cz>
Date:   Wed, 8 Mar 2023 11:59:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] maple_tree: export symbol mas_preallocate()
Content-Language: en-US
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Danilo Krummrich <dakr@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
References: <20230302011035.4928-1-dakr@redhat.com>
 <20230302015242.xi3y53okc4skmonn@revolver>
Cc:     Christoph Hellwig <hch@lst.de>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230302015242.xi3y53okc4skmonn@revolver>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/23 02:52, Liam R. Howlett wrote:
> Thanks for the patch.  This should indeed be exported.
> 
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

What uses it? Don't we export only things used by in-kernel modules?

> * Danilo Krummrich <dakr@redhat.com> [230301 20:10]:
>> Fix missing EXPORT_SYMBOL_GPL() statement for mas_preallocate().
>>
>> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
>> ---
>>  lib/maple_tree.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>> index 26e2045d3cda..3bfb8a6f3f6d 100644
>> --- a/lib/maple_tree.c
>> +++ b/lib/maple_tree.c
>> @@ -5733,6 +5733,7 @@ int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
>>  	mas_reset(mas);
>>  	return ret;
>>  }
>> +EXPORT_SYMBOL_GPL(mas_preallocate);
>>  
>>  /*
>>   * mas_destroy() - destroy a maple state.
>> -- 
>> 2.39.2
>>
> 
