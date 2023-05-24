Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE7270EA81
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 03:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238833AbjEXBD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 21:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjEXBDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 21:03:52 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E397BB;
        Tue, 23 May 2023 18:03:51 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1ae4be0b1f3so2585595ad.0;
        Tue, 23 May 2023 18:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684890231; x=1687482231;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Scbr+czzutjcyOp4HOTyf4rXyCANGJqRT5giW6dSzns=;
        b=VUHlx0hdrMJeI24jSkn2EnyYpoHpIyLCzUsiVdwuMpETvnvFXQwq+SLSzRgm4knxNz
         pZV2np2QA76RnNOcUf1vztGhCv+L+o84mgV/G21TqNs3iChUROFMroxAo8dAUp391eAp
         6e2cRJHsoDz5H0buGQrpHHmGI6kasmrjNRKKWJEZ2qjKNOiCSXFz2OTvuUiZiEzfQY1k
         zMQzE8CVCiCZfvw9PDNxnXzJgu6TrlxexoPt+WvoRwECAHIqSMpjP8UvHSfXB9x08esU
         yv3OzQides6Ohaddqhx4sEcfwiib66R6Mor4BEwY+JuCIFYJ5+HIgw60GPkN62iKGfuC
         8+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684890231; x=1687482231;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Scbr+czzutjcyOp4HOTyf4rXyCANGJqRT5giW6dSzns=;
        b=NiKBMD9weiFbMlNomhtJEHDBWDRkLJhjReesKAHe6yoyZeGnSRppNCD8a+xt4cbqq6
         BK3N7ClafaJ49bcYktbC0d9xkQpg8PGMsbsgHU3oqqUBImjQ35471j2D/kqpF70gN/yo
         A4ydWEkiKvvsFpnfmOPyfYz2myh+4Xh+AtZnshJ3uHyHtP+TdwEMSgkmBajq9xzTUa55
         G3Ii82ggePvBhC2Mw7cpz6bGiMIjW7XqmgeQwRJQWV8xlpXdvEYw+6HOU9gD1wblo5dB
         +eOLQk6BJClBQwJrYmyqdwwqTUV4dMghmeLC7WtghWiUo2Y0+RDAkZ+eXsN3rMy23wxV
         gqmA==
X-Gm-Message-State: AC+VfDzf71PLXJq4r8rhIdeB4rr3EoevTeyVq7bZC8jnbPLbiBFj1gS5
        lCbG748c2gQRum0bbXBGId4=
X-Google-Smtp-Source: ACHHUZ5iY7CoRA4A35tUPceEOlzHvdghzUGl9NlWcSBqdQflyGW3bnKeWyF5cfg8O+er6f06wPuQCA==
X-Received: by 2002:a17:902:ea0f:b0:1ac:8062:4f0b with SMTP id s15-20020a170902ea0f00b001ac80624f0bmr16597872plg.59.1684890230365;
        Tue, 23 May 2023 18:03:50 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-87.three.co.id. [180.214.233.87])
        by smtp.gmail.com with ESMTPSA id g8-20020a1709029f8800b001aaf6353736sm7417553plq.80.2023.05.23.18.03.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 18:03:49 -0700 (PDT)
Message-ID: <dbcd41cb-3355-d052-07a0-093638e36a2b@gmail.com>
Date:   Wed, 24 May 2023 08:03:43 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] fs: udf: Replace GPL 2.0 boilerplate license
 notice with SPDX identifier
To:     J Lovejoy <opensource@jilayne.com>,
        Linux SPDX Licenses <linux-spdx@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Actions <linux-actions@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Cc:     Jan Kara <jack@suse.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Diederik de Haas <didi.debian@cknow.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
References: <20230522005434.22133-1-bagasdotme@gmail.com>
 <20230522005434.22133-2-bagasdotme@gmail.com>
 <05210fe3-8392-08ac-2cc0-cf7fd9b6a05d@jilayne.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <05210fe3-8392-08ac-2cc0-cf7fd9b6a05d@jilayne.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/23 00:58, J Lovejoy wrote:
> it looks like in a couple cases you have removed the word, "COPYRIGHT" and in the other cases you have not. I could be consistent one way or another and lean towards removing it, as I see it as a heading for the old license notice, but Richard may have a different view :)
> 

I don't have the context that you mean (I have no idea what
code you're referring to). Please reply inline with appropriate
context in the future.

-- 
An old man doll... just what I always wanted! - Clara

