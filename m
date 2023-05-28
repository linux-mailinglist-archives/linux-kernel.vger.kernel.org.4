Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FB5713BB2
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 20:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjE1Sha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 14:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjE1Sh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 14:37:28 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C56EAD
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 11:37:27 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-397f13944f2so1849405b6e.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 11:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685299047; x=1687891047;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Sxz/+Nc9167ApWrleeKYEGsyKyqRexgoIRa/vUrynzw=;
        b=KB+aAQGWZdGfApni3zT1E0nCit0GR9uCwihN4JiJeRcwKxa1c64QmtAbbzD4CCKTpf
         FUwRz4rjv2Thu0lYwVC0qKPOlAJNnhqetb6gJg521bYJKkR/RKnMyxrHWmmsVfv3FWrn
         Gs9CdGzzXDOepbHJlfJgMZkxo8ubSgC+PG41A4TnwxzFE+1fU4X9GIca8pMMwS1CK50a
         xgptP8b0DPwPWCaWLO6yi8QtH9Ja/KpdwOJBATg59WQ9+35nzjbEG9UW6WudnMWqp4eq
         s3Z/EAgoEFaM27Ayt55n0igkyUBBEtUq32Vu0CybeFmjYx/A5VlTkfeBea1zBIpgY4B4
         4cHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685299047; x=1687891047;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sxz/+Nc9167ApWrleeKYEGsyKyqRexgoIRa/vUrynzw=;
        b=dN8RaGZ5eNCaLzEZB72zdqAHhqYhM4NaCi1GRr2IQCvLstcA095LC3sFVs/0avwihG
         AdqoxAODrBZ4O7jzpAbr/nStQsRbp6lVDoefnyxxm80GJL/Tlv7i7Q3uvE+GPAfFBs7U
         LNzl+ZtjrBJPtZVmc12h4y2pqybDJvaA1O+b9FlQxAuw4jACbEVE53r7fivxwNmnj72p
         76EjwWOFkcMSG2syHBQOKj9mwo6ls7mOWzk+PiSpzIg+YTu4ItH4a7/ED2+BL261IyCA
         Y5D56vEwjJ9t4/G2a65IOueq4Z1E6FXn2QP++8C3oKkJOMC7FSDacGKzo0dwHkK0LEWw
         hnKQ==
X-Gm-Message-State: AC+VfDwfTGQfM43Biwnsl8iLjoeUUwccbt3m+GHcoSZheYZqV/omc8gx
        yotqYun+Ra4tckGHIWMo9Bk=
X-Google-Smtp-Source: ACHHUZ49Fo6RGpHQdq5SBtmkbZW90hiDMAg6W6ahtdcB6s8IfY1u52o+HyoeTa+Eku4aLDO1f8GqIA==
X-Received: by 2002:a05:6808:10d4:b0:396:3b9d:7ee0 with SMTP id s20-20020a05680810d400b003963b9d7ee0mr4595766ois.41.1685299046871;
        Sun, 28 May 2023 11:37:26 -0700 (PDT)
Received: from [192.168.0.200] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id v188-20020acadec5000000b0038ee0c3b38esm3947107oig.44.2023.05.28.11.37.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 May 2023 11:37:26 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <0bcc883c-dd71-c6d2-f642-ee1315316c5d@lwfinger.net>
Date:   Sun, 28 May 2023 13:37:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: staging: rtl8192e: Replace drivers rtllib_crypt_ccmp_... with
 lib80211_crypt_...
Content-Language: en-US
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1683960684.git.philipp.g.hortmann@gmail.com>
 <e3c29c3db33d314dffb673f8e563da0fb1f2b22f.1683960685.git.philipp.g.hortmann@gmail.com>
 <acac3ff7-36cd-72b4-1857-c8e3588d287f@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <acac3ff7-36cd-72b4-1857-c8e3588d287f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/23 01:38, Philipp Hortmann wrote:
> Hi,
> 
> it is possible to remove three modules from the staging area by replacing:
> rtllib_crypt_ccmp with lib80211_crypt_ccmp
> rtllib_crypt_tkip with lib80211_crypt_tkip
> rtllib_crypt_wep with lib80211_crypt_wep
> 
> The following issues arise:
> - rtl8192e needs to be switched to software encryption or
>    lib80211_crypt_... needs to be extended with hardware encryption.
> - Performance is dropping on my computer from 12,5MB/s to 1,5MB/s when
>    switching to software encryption.(it does not really change if I use
>    rtllib_crypt_ccmp or lib80211_crypt_ccmp)
> - Fix: rtllib_rx_decrypt: decrypt frame error that occure sometimes on
>    lib80211_crypt_ccmp
> 
> Below the changes on the driver that made use of lib80211_crypt_... possible.
> 
> So the questions are:
> Is it worth the effort or is this going in the wrong direction?
> Does it help the kernel community or is it just creating more effort?
> Why does LIB80211 not support hardware encryption? Or does it?

I do not know why LIB80211 does not support hardware encryption, but the 
performance hit you report is not acceptable!

Larry


