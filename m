Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F87750BA6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbjGLPCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbjGLPCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:02:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E7A1BE3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=QE2l04KQ/g7n/6PUYobLNmmkJH6BtKi70gvGkOJW4ws=; b=22xcVrXBRsgyhpFVVdMwPv1Q8b
        SghlPAkrcZ5sQmm9avNpYE24BhMKxhH3YTWJM3Y2XizG2i1iVPK317MmdtKTtSq62mqwBa62adlAs
        7BRIPw2SXk85MrZh5SH5zjovyQqWPKmeqDMYkKHdmg+1HKky0jL7XdPV3KLWL31RVNB9A7GnuDZWx
        Zm2Y8HgvsGIHo+VMcwlCb+o4W9V8sJ87ykoIQrwyFwhjwgvk/NKd8YBlFcxkRqI6bFnevi3ykBGzE
        1avSPRuZtfJ93eCfy95Tunrk/sgnkb9x1gtizot9GjtIHtuL+fU1cOBq8vOP6V2StYmmMP2LFesbv
        KOzLoaKA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qJbLy-000HGA-1h;
        Wed, 12 Jul 2023 15:02:06 +0000
Message-ID: <684e0db2-cf7c-d5e0-97dc-668d471e37e9@infradead.org>
Date:   Wed, 12 Jul 2023 08:02:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] x86/amd_nb: Fix warnings in amd_nb.h
Content-Language: en-US
To:     huzhi001@208suo.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org
References: <tencent_D99F165759804D6F6D54F55E9D09438AFD06@qq.com>
 <a230e226d36fae8d173c39d4ea844af5@208suo.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <a230e226d36fae8d173c39d4ea844af5@208suo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/12/23 06:02, huzhi001@208suo.com wrote:
> The following checkpatch warnings are removed:
> WARNING: function definition argument 'int' should also-
> -have an identifier name
> WARNING: function definition argument 'int' should also-
> -have an identifier name

It appears that checkpatch should be modified to say that function
definition arguments should have a meaningful or useful name,
not just an identifier name.

> WARNING: function definition argument 'unsigned long'-
> -should also have an identifier name
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> 
> Signed-off-by: ZhiHu <huzhi001@208suo.com>
> ---
>  arch/x86/include/asm/amd_nb.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
> index ed0eaf65c437..73a70daa919d 100644
> --- a/arch/x86/include/asm/amd_nb.h
> +++ b/arch/x86/include/asm/amd_nb.h
> @@ -18,14 +18,14 @@ extern bool early_is_amd_nb(u32 value);
>  extern struct resource *amd_get_mmconfig_range(struct resource *res);
>  extern void amd_flush_garts(void);
>  extern int amd_numa_init(void);
> -extern int amd_get_subcaches(int);
> -extern int amd_set_subcaches(int, unsigned long);
> +extern int amd_get_subcaches(int value1);
> +extern int amd_set_subcaches(int value2, unsigned long value3);
> 
>  extern int amd_smn_read(u16 node, u32 address, u32 *value);
>  extern int amd_smn_write(u16 node, u32 address, u32 value);
> 
>  struct amd_l3_cache {
> -    unsigned indices;
> +    unsigned int indices;
>      u8     subcaches[4];
>  };

-- 
~Randy
