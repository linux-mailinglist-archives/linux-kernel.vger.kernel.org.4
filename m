Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BB7719060
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 04:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjFACI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 22:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjFACIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 22:08:55 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169E3121;
        Wed, 31 May 2023 19:08:55 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-2565b864f9aso59410a91.1;
        Wed, 31 May 2023 19:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685585334; x=1688177334;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3oX7QLOAzm6QWUBabTjRoRDv03PwxV5OaOraCC7VjOQ=;
        b=QmdL0GPWAgSelup5ZEXgiS4Kt2zjZ0zSD30b4E9BoiOnHwEU5BM4KDD++laeCitJs9
         FfiJtLDzT7+DFcYgZAh5qAWGQ65zcOu2ieiWd0aYLd09Y+ONeEu3dNxxt9X20jPkdC0Z
         MBs22NDXRoK+M5iwkFmvxod95zs6Yj4Da6OorYq3S1UAvbNMs6nd485YehrBbdZR50vu
         gj+g3v7va1nq/ghw1o7ICPuzsEBpKehOikQanDBX6kujJBnbp8iTAj/2gMQsMmN8TAEE
         pNralqAgWXaA4Jh0cdnSAA6Ye8/zZvvMMl4kTtD0Cj/fifkz1R2oFcW0VBeeU+n/LXQc
         88+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685585334; x=1688177334;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3oX7QLOAzm6QWUBabTjRoRDv03PwxV5OaOraCC7VjOQ=;
        b=JgPJ7Z5yNxe5U4WPbPVG1s32ExRGCwiNvL5YehR/N6bBH3sAwsnT6ytPhvqG0Jc1Io
         0daDwIilJjByhPuglEhhjoTq5EZTOgXyDEzWStZ5d2OlztFsxK32ViL7wDjkZjfE5NK6
         09mncwEH4/1uRttYNGMiZlNwg7hRuArGgctfjEbEqFV8h+QGzf0rLd4ZA3h+B6JL1xGR
         dhoSRrqT3ueQLqls3r8jH/n/jiF0Dz2zyBllVX5npJu5LmGsnx2QKaInTSI0G4Rxl/ij
         64ZTKl3UoOzormzxS347G/JYTHpbhwmEAy2Zdd4WW0MtGOvOy/JBidRsll2DjgJFjSJn
         caMw==
X-Gm-Message-State: AC+VfDzLD8QLsnAwfuI+klaCc9s2gtaoNIc8JKZLXf2pz+x58NpLwRC0
        ps9YC46JFaBt5WIxivCpJa4tDuOORLXHzw==
X-Google-Smtp-Source: ACHHUZ46vtjiRqs9XzP0DVwSkRPTcJVVkos/z7I8p3nD5k48XuniFDSUl/pA8pKgNEpkVC5cWkdCtg==
X-Received: by 2002:a17:902:b18f:b0:1ab:7c4:eb24 with SMTP id s15-20020a170902b18f00b001ab07c4eb24mr4856292plr.22.1685585334400;
        Wed, 31 May 2023 19:08:54 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-81.three.co.id. [180.214.233.81])
        by smtp.gmail.com with ESMTPSA id je4-20020a170903264400b001ab2b4105ddsm2106399plb.60.2023.05.31.19.08.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 19:08:54 -0700 (PDT)
Message-ID: <e783e493-23a4-0cec-eb6d-f81400324b74@gmail.com>
Date:   Thu, 1 Jun 2023 09:08:49 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 05/11] Docs/scsi: dc395x: shorten the chapter heading
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, Oliver Neukum <oliver@neukum.org>,
        Ali Akcaagac <aliakc@web.de>,
        Jamie Lenehan <lenehan@twibble.org>, dc395x@twibble.org
References: <20230518212749.18266-1-rdunlap@infradead.org>
 <20230518212749.18266-6-rdunlap@infradead.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20230518212749.18266-6-rdunlap@infradead.org>
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

On 5/19/23 04:27, Randy Dunlap wrote:
> -======================================
> -README file for the dc395x SCSI driver
> -======================================
> +==================
> +dc395x SCSI driver
> +==================
>  

Acked-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara

