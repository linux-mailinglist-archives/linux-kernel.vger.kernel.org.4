Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E386FFEFF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 04:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239689AbjELCge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 22:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239158AbjELCgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 22:36:32 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3753659D4;
        Thu, 11 May 2023 19:36:31 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1a516fb6523so88099335ad.3;
        Thu, 11 May 2023 19:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683858990; x=1686450990;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JLOnR+TZq7I0ACsVGp4QS0zHoJpqoYfqy4vPmKAWQdI=;
        b=sB4gSnD9iXxiHEzCZ5632EilGI1/tk5kFTaJ+wlHXJc+sxwpTgaSN1Z8mCdj3VPC5/
         sFPcLSrSDoD9Iblo9FyNo9D6HfkLeczZM23f0l2cTI3Fmrd0xL20DwYlD40F+q0bih/7
         1WURb8MDTO0CZdR7j+8vYB/sWeobgEESxa0FOnUwSrmN1Vn+l8UUJr1D8OIQJhXU0mTd
         Ky2IQvNxjqymrgcH8bbyPR84YU+Ew1ZKu8cleZ0uHh6Oa+9q/0WedjPqMVqvBlvhUcut
         /q9Zht61gq31ydcyuKMeL4onDUgH+kIzEoI9FlfE4/Aed8w3+M7/Ix+CsARZrwxBDnGt
         GHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683858990; x=1686450990;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JLOnR+TZq7I0ACsVGp4QS0zHoJpqoYfqy4vPmKAWQdI=;
        b=Ewq+nYOjxnCdXFMn/cfMeVbAxccz/8w+sNbCnbk78iATPSM58slzVibhtpz1h0PPVo
         p24/SX3U9O9NGG7vxGRkpquWQFJoNB0N73Rwny8SZos8b43cBQpkFF2FCZwGCV6c4UnL
         EyO1M3iZ/sOiMIqk+88+21KgDSVWyh532eL+rEf88Zl1CiLPbMYxbPdbWFdYAHb7RUEm
         rWJwgwyL3mPKfod4Bj89ntf87wBzh3sX73KtOfJqFMwpaLvtW04Zxqn2tKlXlHYchlpO
         WSF6DrK9j+ZkrNrEJe2c8iTCsgj/szr1lqVW44x3m4FggSp34jRpRv8xznSlIIr5NNoA
         KflA==
X-Gm-Message-State: AC+VfDyy67oBtVZavjEpPO/1nPzPe2Tf5DGo+u080kzMV4QwYmFvk+EN
        ZxjhRcysPLbwXXtHp+9Ap4s=
X-Google-Smtp-Source: ACHHUZ59m+n7obFadBYYqI+7nMSPeg1gXvLySTC5HjO3gnt4GQRdhhRs8CIjLkDV1Y0XFALcXuG+qg==
X-Received: by 2002:a17:902:d2c2:b0:1ad:cef8:f916 with SMTP id n2-20020a170902d2c200b001adcef8f916mr3631543plc.1.1683858990577;
        Thu, 11 May 2023 19:36:30 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-24.three.co.id. [180.214.232.24])
        by smtp.gmail.com with ESMTPSA id y18-20020a17090322d200b001a1a82fc6d3sm6595884plg.268.2023.05.11.19.36.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 19:36:30 -0700 (PDT)
Message-ID: <f74a911c-82c5-b4d0-1406-0acb5a327312@gmail.com>
Date:   Fri, 12 May 2023 09:36:22 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] Documentation: module-signing: Mention
 default_x509.genkey template
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Keyrings <keyrings@vger.kernel.org>,
        Linux Kernel Build System <linux-kbuild@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <20230511043852.25803-1-bagasdotme@gmail.com>
 <CAK7LNATY7EEWy6krs+J-XzXDzmuKQ4Ae4RrxEH6mX=SmcWCiPA@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CAK7LNATY7EEWy6krs+J-XzXDzmuKQ4Ae4RrxEH6mX=SmcWCiPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/23 23:55, Masahiro Yamada wrote:
> On Thu, May 11, 2023 at 1:39 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>>
>> Commit f3a2ba44e93e2c ("certs: check-in the default x509 config file")
>> adds default x509 keypair config file template, but forgets to mention
>> it in kernel module signing documentation.
> 
> What did it forget?
> 

I mean the phrase "provide your own x509.genkey" can means
creating that config from scratch when there is already
default_x509.genkey template which can be used as a base for
adjusting certificate keypair.

-- 
An old man doll... just what I always wanted! - Clara

