Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624916005EF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 06:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiJQEP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 00:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiJQEPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 00:15:21 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE0B28722
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 21:15:19 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 128so9425157pga.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 21:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZJV0FwVXHVDUtfEx1uj/obVmAiz5b1ilKz2Oe2cH3DM=;
        b=VV/GGCh1ZpRXD4ojMik0RVa29xcFUNc0uXuYE//HQxHlUAIv5MVT7wPLyNA6IpsaGO
         b/bnjQGOaTjr6Pwo1TpXgqaEL1FIn8E/TEd5u2bB2fubE62Xzy3NldjjC80bC4U/7AvN
         KFYRaxKb/9Da3TBBtJPKnrbxFSQUizggOExnng65Emc6BfgM3vxDO1VW1mymxRN6SeRk
         G1OPn/8JpEoGNG2ywNYjGCT4lcRXuwQe7m1Uc3USI4be9iJcErJPlX5HsdUPZjkQiwK5
         Af+VYnd3MrX6ZhiDkSFSRdSZWN1zf8byVUUN1HKCQMWF7JB31GhdnISQiCKHF/WmJhiJ
         WK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJV0FwVXHVDUtfEx1uj/obVmAiz5b1ilKz2Oe2cH3DM=;
        b=ziSBglCMeIXRyRdsrd23edRnaRZPTYzCkj6+jJoQExPuyYJGbkHKdMiQpsv/citmaf
         QL8Ga/HEvlvZhWeVDaMTyraqM/oC6FjLKgoESLeRpfVxZyN1ybWlkh+ixaw2tjVpvxni
         4De6V/kXQfGk7ZNWdXLKdbmXR5mchdBv+x/kv58R4UdO97qtWQqhN0B3BELY9+hjrFg0
         iz6R4qmHmm4O5yRo/FJlZce3jlTEWypoK2s1/rUFIJYOGCVjVKLoVvdipUBpLRtwaQO1
         g9DT1M8YKlLf9xcvN12s3PMNubHUuDGP7SN7d1Gh6LkVHQxXiC6pLjXof9nhJNB7OM95
         SzUQ==
X-Gm-Message-State: ACrzQf0U7WRoKhmc5dcYOG+eBdnF72O1mC7dC1UX0cKF0tDKUARuf/Tt
        KRn29QHDS4q40TSVGIkEXI0=
X-Google-Smtp-Source: AMsMyM4wAtkmQOUeh5seZ05cBVAyfp8ywzFUudGDAKmtCqcI6TJVEu+lTM4ebghcaOWVmZBsTXE42g==
X-Received: by 2002:a05:6a00:1707:b0:563:235:769b with SMTP id h7-20020a056a00170700b005630235769bmr10507561pfc.19.1665980119039;
        Sun, 16 Oct 2022 21:15:19 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-89.three.co.id. [180.214.233.89])
        by smtp.gmail.com with ESMTPSA id i18-20020a056a00005200b00561b02e3118sm5814390pfk.106.2022.10.16.21.15.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 21:15:18 -0700 (PDT)
Message-ID: <928b701c-b35f-a621-b32f-edf9d8bf6696@gmail.com>
Date:   Mon, 17 Oct 2022 11:15:14 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: BISECT result: 6.0.0-RC kernels trigger Firefox snap bug with
 6.0.0-rc3 through 6.0.0-rc7
Content-Language: en-US
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        regressions@leemhuis.info
Cc:     linux-kernel@vger.kernel.org, marcmiltenberger@gmail.com,
        regressions@lists.linux.dev, srw@sladewatkins.net,
        phillip.lougher@gmail.com
References: <8702a833-e66c-e63a-bfc8-1007174c5b3d@leemhuis.info>
 <20221015205936.5735-1-phillip@squashfs.org.uk>
 <ff2b901d-9491-c886-5330-a244101978ab@alu.unizg.hr>
 <b71f4e2d-23bb-3eb4-3928-fe66c4357e5b@squashfs.org.uk>
 <beba6259-6049-4f5b-6e54-a9c1faba0d5f@squashfs.org.uk>
 <32ee551f-5642-4efb-02a0-500e7c92be5f@gmail.com>
 <b7aefbcb-0038-d044-a1ea-64ad5b4d8888@alu.unizg.hr>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <b7aefbcb-0038-d044-a1ea-64ad5b4d8888@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/22 09:41, Mirsad Goran Todorovac wrote:
> I can only report that bug persisted in 6.1-rc1 with the latest Phillip's squashfs patch.
> 

So the regression isn't solved yet with the patch, right?

-- 
An old man doll... just what I always wanted! - Clara

