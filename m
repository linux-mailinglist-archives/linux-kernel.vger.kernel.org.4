Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BEE602082
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 03:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiJRBif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 21:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiJRBic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 21:38:32 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4E96FA2F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 18:38:31 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id y191so12742239pfb.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 18:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TTN2qy/2Qm3Cw70dkeqCjjtl13hYeoHtMcpkFhAGPg4=;
        b=Ex3v7UqFs94RXJcwwvMbkAGYksXE5bGisSYjN2dEpo2GoM2E6p8/ptfyd6EC7+29my
         wZbyaqmsHfTwQIPpO+mpzVNAwNWPMgHY9Q4Zzhb0hBl6Wi5Y1hoxwob2YQ85LoB/eOJQ
         KbHcKRARsrwGxhD2fRcUI7rMKbc/JHXQsL29Knhn1TiPiHJX+t8CNLESTWD4HQOQf+Nd
         zrhS+Xf8t1OxyRF072ldNS7DY/hGluWNmwfnkioqkZK8Yu25hMrWHmlXdl9D6nba2MYO
         MnrMzzsHm6yyzUw8c7wCIL2mdz6CgGh0DcEN+6+DaXpFxClPdAYIbxWuEVK4Hf8w+GAL
         RO6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TTN2qy/2Qm3Cw70dkeqCjjtl13hYeoHtMcpkFhAGPg4=;
        b=yxu0+eHL6tVTxxxKLnDraRNY14NBAbZYnPTz3B/KJHlLxZCFyB45gvHifdn9P9cgiX
         BVLJI37O9/GwsjZUanvFPDYVSVX5WvIpXNrfl5ivxtkLPQBG7mdAXRrxSqPdy7p9g6xs
         LRcT2ktXumKFr4fcAfrFHsVMLEtSyxPxNIjHlHbuE1lLmWpOAXKI9P84Mcws2jIhooow
         nQoV0JgHkgnT2ggjlR+/st9hgflVtisKn3IB1V+2pdx0zg187qOlDQhcR8SEvAkiIW/I
         sFTQzcJu/lpiqkaOx2N5R9H/qcDXg/5gwwEOmj4HUR1CAKUesEVh1kHd4916QxmSlXlJ
         9jPg==
X-Gm-Message-State: ACrzQf3YGmzzO8Yf77drUmJnNWQ0tA7BQhyTv85VqTXbIaX4CFUM+/0Q
        VtkqUEw1sUC7OiU0JCVjzwc=
X-Google-Smtp-Source: AMsMyM756V46Q8irXvQqiVVGmdO4dWcn23ABv1HPOdALD3Bmccmyvfb7CXTvs7yr+nL4cWPgGCRndw==
X-Received: by 2002:a63:1521:0:b0:43c:9566:7a6a with SMTP id v33-20020a631521000000b0043c95667a6amr560772pgl.339.1666057110889;
        Mon, 17 Oct 2022 18:38:30 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-16.three.co.id. [180.214.232.16])
        by smtp.gmail.com with ESMTPSA id e17-20020a17090301d100b001782398648dsm7352461plh.8.2022.10.17.18.38.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 18:38:30 -0700 (PDT)
Message-ID: <a606463e-7139-b2d4-e2cf-eef2ec38bf10@gmail.com>
Date:   Tue, 18 Oct 2022 08:38:26 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: BISECT result: 6.0.0-RC kernels trigger Firefox snap bug with
 6.0.0-rc3 through 6.0.0-rc7
To:     Phillip Lougher <phillip.lougher@gmail.com>
Cc:     Phillip Lougher <phillip@squashfs.org.uk>,
        regressions@leemhuis.info, mirsad.todorovac@alu.unizg.hr,
        linux-kernel@vger.kernel.org, marcmiltenberger@gmail.com,
        regressions@lists.linux.dev, srw@sladewatkins.net
References: <8702a833-e66c-e63a-bfc8-1007174c5b3d@leemhuis.info>
 <20221015205936.5735-1-phillip@squashfs.org.uk>
 <2d1ca80c-1023-9821-f401-43cff34cca86@gmail.com>
 <c5980bcb-f345-ff2e-a29b-75e53a6b8708@gmail.com>
 <a1d46bd2-9603-f89a-ec85-ebcd25db8882@gmail.com>
 <CAB3wodeqmuE0iZeSddWSGuJ49rKUjSPb9xxsx189hdL9aMn_pQ@mail.gmail.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CAB3wodeqmuE0iZeSddWSGuJ49rKUjSPb9xxsx189hdL9aMn_pQ@mail.gmail.com>
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

On 10/18/22 00:25, Phillip Lougher wrote:
>> Sorry for speaking late about my triggering cause.
>>
>> As the background, on my Debian 11 computer, I have lxd snap installed.
>> I use lxd to channel my sysadmin side by spinning up containers and
>> installing server applications there (LAMP, email, DNS).
>>
>> Back to triggering cause. I can trigger the regression when the network
>> connection drops (when Firefox shows connection problem page). Then
>> I run `lxd list` to list container instances and I get the Verneed
>> regression error.
>>
> 
> This appears to be both deterministic, and appears to show something
> happening in the Firefox snap triggers an error in the Lxd snap.
> 
> This will then not be a Squashfs issue.  Firefox running in one
> Squashfs filesystem
> can't trigger a failure in another Squashfs filesystem.  This has to be caused
> by something else.
> 

Hi Phillip,

My Firefox runs from upstream tarball (not via snap), so the problem may lie
on snapd itself.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

