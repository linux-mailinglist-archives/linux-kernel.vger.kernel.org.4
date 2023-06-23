Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED87973BDBD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 19:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjFWRVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 13:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbjFWRVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 13:21:01 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2163F2952
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 10:20:48 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-94ea38c90ccso18971766b.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 10:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687540846; x=1690132846;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wm1WVoIbn3lR/yYEwl05EQlAoyEzS9kcMhjBtJTS530=;
        b=Qgmk66gpXSiGi9NZhO6CuX/XFzR7A1R0Tm6p/GxMbmWSmO0O4mXQgeQYAha59aNOW7
         nySIl2nAiMoGJrC/XIqueQdWfDmG5MY6UOOAbAnOrnJ+rXNCswAWECNzhMYhnOAOra8r
         rN/O4Kkq/6kNhfk4D41p3+oAquI+iHN1UhQcRUE3EMG9mKkZ7mRxMRqeP+bBXAZG046O
         9Bu9qYMIQM6TXHfiH8KRj/lJ2n1uOrYw3H+02zVyLiaLu59Aw0b9MGTtoYsPgr9/EYP8
         EfZK2VzRw0r6HeBuCLx0c1N1zC+7n4v0n3q27s7VKKBJG5TzjV+5rsH/5rc96FuI9qLb
         yBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687540846; x=1690132846;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wm1WVoIbn3lR/yYEwl05EQlAoyEzS9kcMhjBtJTS530=;
        b=h7ARBj87qH/KnxlFSiyUPTopeVoOXs+xqwdH3tqm1W/EXocybvm4Hhn5CMcVfUqhuy
         w6I8+BypLMGncQxUXFxZ1e/zaHDisxca+dlOv54Rl2b575UhKcfSesa5T+3xA3Q6fD8f
         XZ+CGuP6vlf1Isvu7XDF6gYU9YlsittDD65605NXe0jHKaxn70OUqLOYQ75Ika5qbSQr
         6lXSWMh9iCWbtCxIRp+zRJ5hphLA4ZwpMfxvYvwG8/0Q0sSMqokk+WIj9TU6mFn6rYne
         7D44qnELvjiRYnkYDv+JEydxtY5v+Z/yR5OnV/P9CEAEKLVlrsl/NayXrNB6dRU1TPpA
         lqfQ==
X-Gm-Message-State: AC+VfDxy/wOo9dwj7IFX9tiOeonLPAyNlR7Jtrs3bLcdpqb+NoqVYKwZ
        xb1TdYpoFZ1WsuGY+zj6Sig=
X-Google-Smtp-Source: ACHHUZ6liZZCJdt+mtGxv5CyN1Yl6kvTStu+cUKc2NRwZ0GEhpbyH8XanIfHLIfaEBG58yvuWzKt0g==
X-Received: by 2002:a17:906:73cc:b0:98d:b10f:f3cd with SMTP id n12-20020a17090673cc00b0098db10ff3cdmr591020ejl.7.1687540846180;
        Fri, 23 Jun 2023 10:20:46 -0700 (PDT)
Received: from [192.168.0.103] (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id a20-20020a170906369400b0094e7d196aa4sm6163147ejc.160.2023.06.23.10.20.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 10:20:44 -0700 (PDT)
Message-ID: <2d1ba862-961c-ec91-3a28-7f2f221b90d4@gmail.com>
Date:   Fri, 23 Jun 2023 19:20:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 0/5] Fix some checkpatch issues
To:     Franziska Naepelt <franziska.naepelt@googlemail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        eperi1024@gmail.com, hdegoede@redhat.com, quic_vjakkam@quicinc.com,
        johannes.berg@intel.com, tegongkang@gmail.com,
        Franziska Naepelt <franziska.naepelt@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
References: <20230621184635.25064-1-franziska.naepelt@gmail.com>
 <2023062306-reload-squeezing-633a@gregkh>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <2023062306-reload-squeezing-633a@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 6/23/23 10:18, Greg KH wrote:
> On Wed, Jun 21, 2023 at 08:46:35PM +0200, Franziska Naepelt wrote:
>> This is a series of patches to fix some trivial checkpatch issues. Not all
>> issues have been fixed. I intend to submit another series to fix more stuff.
> 
> None of these apply to my staging-next branch :(
>

Hi,

this is the repo and branch I use:

git remote show origin
* remote origin
   Fetch URL: 
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
...
git branch -a
my branch: staging-testing

Bye Philipp
