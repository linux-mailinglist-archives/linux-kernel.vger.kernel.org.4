Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFF15F9383
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 01:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiJIXVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 19:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbiJIXVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 19:21:15 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413B85F9AD
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 15:47:17 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id v17so5840491qkv.5
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 15:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qoQaMugHvTPaZz2yjGnEv+QBAEt4uVbYTr3+LciFdvU=;
        b=F5Vr6E650I+JLLUTWnewNpyX7fwWtKUsQa7o2NeiE7hJKD4TIDPtgMbDwSrXk8EHsG
         wDTaP1m3rKboduR7qUdJ6yGvAB7JktS1Ds0vyNmdHDtez8eSeOPWfrmfXPAYOvnb/Kds
         DQaRHftXs7HjqsCgseJ9tI+5GSM5VpcxUhBKFHum9qp2SJhLbSYj20RS5uR1a37AZcnE
         q+klbA6cFYVQKkz/xdh5nu2GELn+B75niTJTr1DU9Y/7czUIkmo7Cl+KNZuJfJbSuYgB
         cULKoINRmqFn5FQkHHJ8DPc8Ee5i3ywjMokG1YbCd4hJLmKCZfXvUsUVZ1J4hA1rRf73
         xXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qoQaMugHvTPaZz2yjGnEv+QBAEt4uVbYTr3+LciFdvU=;
        b=Axl3b04k0TzLkofwq43mPkEEYl4RVigLN/FPPWnwkTdN+CA4CdmlM+QtALbdMjeZp1
         F5rp/1SClB65mVPoOTunysX+1vvsivUukIpG6bc7QnxC43rQQc9ewQVoLqIxfiuQ9UR/
         f83jZFfPC/tAi3LLoji0CWWkTaZw2xKxdegBUs+sANBfuB/pDyWhJut4f48sUoGpIyWe
         zC40hzKZVvYPvZJXPG6ehXbYoZyUaU+Dlmw4Oj5AKou6rL9WG8K1kKzAcEIuO+FFlLvF
         oMf3IkxpEZ2G5Gz3KIUjZCyDLJqehoqBZXAUqK58Zs/FNhM3Wx6EgBF6hq0WOwA51iDk
         CbmA==
X-Gm-Message-State: ACrzQf1YldT7Mo5pWeOJpw+sVo5LE5UpcgmcYGFgV9QN5f0H8TVAKirt
        oWL+l72BELOnfEATrxrmPwsQs8s5h1WdpAY9nt0=
X-Google-Smtp-Source: AMsMyM7ulVL1wQfBPElCtOauV4aLGfpZrVw7iXEYP13XRwFIAyE5UrLSubtIcvNXDYTQVVa5mQBEbA==
X-Received: by 2002:a05:620a:1b89:b0:6ce:8b2b:7f0e with SMTP id dv9-20020a05620a1b8900b006ce8b2b7f0emr11158386qkb.15.1665355530077;
        Sun, 09 Oct 2022 15:45:30 -0700 (PDT)
Received: from [192.168.1.30] (pool-108-4-135-94.albyny.fios.verizon.net. [108.4.135.94])
        by smtp.gmail.com with ESMTPSA id i17-20020ac871d1000000b00397c4528a5bsm4653726qtp.79.2022.10.09.15.45.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Oct 2022 15:45:29 -0700 (PDT)
Message-ID: <b5deaa2e-8867-1e0e-6090-422248310dc1@sladewatkins.net>
Date:   Sun, 9 Oct 2022 18:45:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.2
Subject: Re: BUG reproduced: 6.0.0-RC kernels trigger Firefox snap bug with
 6.0.0-rc3 through 6.0.0-rc7
Content-Language: en-US
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     linux-kernel@vger.kernel.org,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Marc Miltenberger <marcmiltenberger@gmail.com>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <b0c258c3-6dcf-aade-efc4-d62a8b3a1ce2@alu.unizg.hr>
 <5bb75cbc-a0db-537b-12d0-889230c865d8@leemhuis.info>
 <0fb2a9ff-df76-8af9-e54a-c2dc6bfd9478@leemhuis.info>
 <bdab45d3-c893-42ff-dbb9-5fa93d0dff55@alu.unizg.hr>
 <dd62210d-d095-f971-2b7b-0ec54fd189a9@leemhuis.info>
 <c05134cc-92fa-dac2-e738-cf6fae194521@alu.unizg.hr>
 <6ba15505-1c04-df2b-237f-b3060f26d2e6@leemhuis.info>
 <25cd0e21-ed8e-1836-b0ec-c052c2276cd8@alu.unizg.hr>
 <c40786ab-8b3b-9b64-683f-dac589c024df@alu.unizg.hr>
 <021de720-4a57-1a88-f456-fcaeaa3653de@leemhuis.info>
From:   Slade Watkins <srw@sladewatkins.net>
In-Reply-To: <021de720-4a57-1a88-f456-fcaeaa3653de@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On 10/9/22 at 2:45 AM, Thorsten Leemhuis wrote:
> Yeah, then it's pretty certain that his is a regression. But it could be
> caused by all sorts of things and I have no idea where to start. We thus
> really could need a bisection to find the root of the problem. This will
> be hard, as this crash only happens infrequently. Thing is: the Ubuntu
> developers likely have a strong interest in this particular issue and
> due to their knowledge of snap have way better chances to pin-point the
> root case quickly. So submitting a bug report to them might be the best
> way forward in this situation, even if the kernel is likely at fault here.

Thorsten,
Yeah, agreed. I haven't had time to bisect -- though it's on my list of
things to do: I'm going to try and make time tomorrow. Wish we had more
of an idea of what exactly was happening here.

Mirsad,
I'd be happy to help with a report to the Ubuntu folks. :-)

Best,
-srw

