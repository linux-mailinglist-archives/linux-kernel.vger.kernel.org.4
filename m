Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40579721784
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 15:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjFDN4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 09:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjFDN4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 09:56:39 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934B7C4;
        Sun,  4 Jun 2023 06:56:37 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-651f2f38634so3337585b3a.0;
        Sun, 04 Jun 2023 06:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685886997; x=1688478997;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=117yVyRXLiZbNEVSmtDOgF7WMAgwu5egOkvBC/5odcI=;
        b=Nza6NKslXjutBq54b2HRVSaCwcmingt2EQQnlYugloMgti34dhsfd0DBZxtEgIIX13
         hVs+Sfc5RwPj4AprLd7GgS5z5rEJjlta/OHHdf5S4rGobWG4obbr5iuTVQ6blGKP6PIw
         VLJTkWLIiH6HGyAW/2iTYkGYbWPpEkerqEo4y/GzR63W2dmh4lpOZ4DTpYtG0zgo+5ih
         II7kYmryIjdJazcoOuaqAffYH9nS8M8032cgKha5NOmYloJdTB/Kp1CouQxSj19Bf4pm
         PPfW1OECf27AACVlOaKXfzjp9ey3qHnBLmxXySvPCnk4rNO6MagoJahXNsFUWejbX4bh
         9klg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685886997; x=1688478997;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=117yVyRXLiZbNEVSmtDOgF7WMAgwu5egOkvBC/5odcI=;
        b=kh5nZ+q76K9hV6xJsbFVG3GC5R+XNoHwOT8fa7bJ4W7iMdDWucCW5jn4qzhfQ34lB3
         Bkmz3DQ3APo5VJ7NJ5DK1p73D6VBLPsBrtfN2Bk4/YKh958UF3ddUNZzUAJyJr7H+xgz
         isvH5csgC5Qlkgqvtvz14RBIVpxq3Ij/LFprAKejExuW79q/5JvuKMsUGnS9FWHo3jcx
         CP30pB4D+XVMR5vbzrz4ZGjfhBv1n60CnYlptvROlD/lmdiHfMTPkQjcc/XRhHKs4dXE
         SBVxNSBb5TrJA6GBtiBvdWL6D3U8/GQy1t1Y/+H3Qj1CTGdOSXoYje4LM/BOuBtW0T0k
         bkyg==
X-Gm-Message-State: AC+VfDxtoEqcVqTxWmj4TETUxTuIps3xBG2jFbBQNJxzgMg+JYsTrN09
        PyI+6BLzMGUwVNJLGqM9dFc=
X-Google-Smtp-Source: ACHHUZ6MBAd8Gnu5v81tMunkT6WV7jiquUQY99c9qc3eYJFzdT7nI9SCx/hOFkmgwXU4AvgAkDgfqA==
X-Received: by 2002:a05:6a20:8f17:b0:111:11a6:920e with SMTP id b23-20020a056a208f1700b0011111a6920emr4828938pzk.18.1685886996922;
        Sun, 04 Jun 2023 06:56:36 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-54.three.co.id. [116.206.12.54])
        by smtp.gmail.com with ESMTPSA id m3-20020aa78a03000000b005a8173829d5sm3709111pfa.66.2023.06.04.06.56.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jun 2023 06:56:36 -0700 (PDT)
Message-ID: <49fa3dc5-ffdb-2af4-9b7a-3d19e88bcbda@gmail.com>
Date:   Sun, 4 Jun 2023 20:56:32 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [RFC] docs: process: Send patches 'To' maintainers and 'Cc' lists
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, James Seo <james@equiv.tech>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Kalle Valo <kvalo@kernel.org>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230603151447.29288-1-james@equiv.tech>
 <975d35cb-e0aa-8ea7-5520-238d1aa4cbaf@infradead.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <975d35cb-e0aa-8ea7-5520-238d1aa4cbaf@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/23 22:55, Randy Dunlap wrote:
> It sounds to me like we should just prohibit (not allow) emails that
> don't have a To: recipient in them. It also sounds like mutt (and maybe
> other software) have problems.
> 

In mutt, there is a command for reply-to-all (named group-chat-reply),
but you need to assign key binding for it. I'd like to type Esc-g
for this purpose. The corresponding .muttrc is:

```
bind index,pager "<esc>g" group-chat-reply
```

-- 
An old man doll... just what I always wanted! - Clara

