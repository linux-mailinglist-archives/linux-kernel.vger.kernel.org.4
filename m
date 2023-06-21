Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0BD737C3E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 09:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjFUHLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 03:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjFUHLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 03:11:13 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCEE710FB
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 00:11:11 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-988aefaa44eso453503666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 00:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687331470; x=1689923470;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5dvTyi8wxIQmAPseTg3IqsVlndTJNTzpv8zE7pEM+Jk=;
        b=K5JEgidftDrgX4O6Ea812KJMDIEzYWSIODKLFTGNkp3MVJfaVprSw7KBGFf7I45q2M
         qgJ1XaUuABTcr063x03nc1xqMv56ms7mmy6/6Amf01Inf/uygPCO4+j/tk35/YM602Jy
         tOTcjI23G5U+jln0btEifG7I24Tml0+EmCS41ZAldRMFtXqxXACxqy0qHAApkUeJlC3t
         7o4Dogju7tveXaxoNRPt3eC+Kkw/7QNkK+aUFnBRLok+N5KOqDon9ZNUc3lzrviWiHUs
         Ixt0K/0FZzXqZVRHGI87RrGKR1N2eaG4UjAObDCW4jC+u8o3TSEwBdvMGyOh31p1+RYZ
         E1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687331470; x=1689923470;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5dvTyi8wxIQmAPseTg3IqsVlndTJNTzpv8zE7pEM+Jk=;
        b=XOYNILAow3q0iqXh7BeIE2JFvdJd+1u2SbjgdyxsXPzZiRGwTpNVqVFccMzqswPFQK
         bmwQp8AZh3mqF2yOpGxvrLyP30ckxK2+BkLx+lKdBRsii5OfwiEP5UJab3tOFpPHEHcZ
         WYnY8r4/kbH+zVLgATIIZ4j/7B1cJpQSiJijdZ5xayHUks/lHSlOufzTkM7wAtbaO+l1
         BjKTUhoN5v47FGPsaTnq+3z4gN9e8VKPAZpB0sexixl26KwYX0qBHBplMNuqYN8ZQsGW
         K3C/ncpAsk03t06pIQAMG4q/DYjhrO7nBBbPNagLMvETfi3kT3h+Mpbl1OCcc9IJBNVH
         FZzQ==
X-Gm-Message-State: AC+VfDxGppS7+/beLrJvF3RlIfBVXcIk+0sG7aO/1NpXh//aAmJ7shiC
        GF1vXmlolwXVsgegnlzZ+xw=
X-Google-Smtp-Source: ACHHUZ4nMVtcJV0GIVaj4PcObJnRidJ6Emufia2L+6+DueBmYR+usB7SZv2ThR2j3CD0rVADJIhG6w==
X-Received: by 2002:a17:906:6a0c:b0:988:bb33:53a8 with SMTP id qw12-20020a1709066a0c00b00988bb3353a8mr6730841ejc.9.1687331470222;
        Wed, 21 Jun 2023 00:11:10 -0700 (PDT)
Received: from [93.173.115.83] (93-173-115-83.bb.netvision.net.il. [93.173.115.83])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090669c200b00982be08a9besm2606062ejs.172.2023.06.21.00.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 00:11:09 -0700 (PDT)
Message-ID: <380c8269-7d2a-293f-7919-8de6776f1cdb@gmail.com>
Date:   Wed, 21 Jun 2023 10:09:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 9/9] char: xillybus: make xillybus_class a static const
 structure
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <20230620143751.578239-10-gregkh@linuxfoundation.org>
 <20230620143751.578239-18-gregkh@linuxfoundation.org>
From:   Eli Billauer <eli.billauer@gmail.com>
In-Reply-To: <20230620143751.578239-18-gregkh@linuxfoundation.org>
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

This is fine with me.

Thanks,
    Eli

Acked-by: Eli Billauer <eli.billauer@gmail.com>
