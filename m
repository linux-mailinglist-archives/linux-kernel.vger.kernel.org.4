Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852BF6A1505
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 03:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjBXCm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 21:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBXCm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 21:42:57 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02C7166F4;
        Thu, 23 Feb 2023 18:42:56 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id q31-20020a17090a17a200b0023750b69614so1271894pja.5;
        Thu, 23 Feb 2023 18:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jxyI/41shoUmIXWxgHt7K1UbQjmbWtbd/7LeDQ6aEsI=;
        b=BeqgUEixZhO78peOPQhqW4yF6VYzakK/ASWVPZzMENNXg5scdTsLjKaGfYXB+aPwuv
         Tf5XOaWq5JDkLVf8gkcWdlBpK032Xz7cD1sIxxSqs4/hdZHr0eqC7rSlEczpdVNtMyqg
         8IJLGL/MR5v1QScxe4knXaTkvE7BExi4+oeZC+jnWUdOjxxxTFlGe5dQ1tClAyQQ2nXu
         z4wzWZwcY9yFagJ/FVJWS0N6GrW5nTA5JbBCp3n5JvGocC/SyBEOcyd6NHZzl0t7W8Vx
         WMgWmDIWcw+FzhPaN9KSKCK+Ak0q0o+y3D1QWSw3XYad0tIEStKTu4bUzUjj4BtNADne
         /whw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jxyI/41shoUmIXWxgHt7K1UbQjmbWtbd/7LeDQ6aEsI=;
        b=VktbvdN2C79X/tkLxpAk/ZrNwUUGdAiZPdoK+QwrlfyLAknt5GU6CmDjlSx8K7Xhf3
         V+QwAQYBzNAfLbmQ2XDtrtQl5hSnQOEXsJJRXO7Kitq2hwb1N+RtwtIiP+gdtMmA8HOY
         MUwSp8U5QzyNSNogWEWXmLVp8kjxFnCqigp4hWkWHVsjkCcPIzUP2FQKEYW3A18U1H60
         12hPFukwWmWabiIsVznvH3JubkEIHWxPCSQA7Xu4OnEI96JHSCSFtzl5/gH095+YmJyB
         cevSHKt11F8aeCOYIDFnLMdIK/m0fNZQr9OPH7IdYx4zhmjmf9KL7QAtJDa80kgloT7U
         oYsQ==
X-Gm-Message-State: AO0yUKVSPXUCdlKtjUsJLJnzfnSdTvqL6qQcTtjmcVLaYlWHve2WN5Vi
        qe1vGNuSIc1ys14pzyu7tOE=
X-Google-Smtp-Source: AK7set8gNKsLF0UkjCWtfWD+CvvdSOV2HDE6PocCDLWIplYCdaISotZ0mg/TLYWF8LBighLrl7nfEA==
X-Received: by 2002:a05:6a20:c89b:b0:cc:3bf0:ed91 with SMTP id hb27-20020a056a20c89b00b000cc3bf0ed91mr2584909pzb.51.1677206576145;
        Thu, 23 Feb 2023 18:42:56 -0800 (PST)
Received: from [192.168.43.80] (subs02-180-214-232-89.three.co.id. [180.214.232.89])
        by smtp.gmail.com with ESMTPSA id s23-20020aa78d57000000b005ad9e050512sm2082620pfe.121.2023.02.23.18.42.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 18:42:55 -0800 (PST)
Message-ID: <5f228150-0e29-6d58-3dcf-776bc2a630b7@gmail.com>
Date:   Fri, 24 Feb 2023 09:42:49 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: linux-next: manual merge of the mm-stable tree with the ext4 tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20230220152938.45f62d5a@canb.auug.org.au>
 <Y/ODNJ3MfoD6dUru@casper.infradead.org>
 <20230221175436.599166f9@canb.auug.org.au>
 <20230223144722.635ab483@canb.auug.org.au>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20230223144722.635ab483@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/23/23 10:47, Stephen Rothwell wrote:
> I still have not been able to figure out a merge resolution for this,
> so the ext4 tree still has had no testing in linux-next and the merge
> window is progressing.  Does anyone want to help with this?
> 

I think at worst, Linus will have to resolve this mess himself when PR
for ext4 is submitted and merged in this merge window.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

