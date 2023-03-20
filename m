Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F83D6C1A72
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbjCTP4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbjCTP4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:56:19 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A64923128
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 08:48:01 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id x11so10637681pja.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 08:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679327280;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f+LL3bEsXB9QuHjteSg7gZpwvkHeWy01BR+xUuCvuCc=;
        b=WWr27uNo5xojKpzZvXzMbW6Bd9Yl7cYepB0TSoJ39CYm3TVS8YYdsOFZ5kNdJd7GnE
         tXUh8mJejDALTPK7tvuNwVhZvGcfEWlrtwC+tAtCHy2HcETpjHaX2ENe4rcEccVM9lwi
         nwLC5GvHmyBruKjiuFw0kVariLl/DG9aXzIJvelKYd73Qw/Jva58EGdo/lLKYUsTK6Mj
         NOK71EBxgbpC+tj9ebjxBQWLqZseid3HmZhv9bMjooFVR7+TcJnJwAJza2v4y76an94M
         SGUJQ1S6jbArZSFai2lBBm3Rds8NFkybSU9oSaYwfD9VkRfBw0Ar4XlIqgYcgqDAiPzP
         Ueyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679327280;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f+LL3bEsXB9QuHjteSg7gZpwvkHeWy01BR+xUuCvuCc=;
        b=QhcsxkjlFZ9EFJYa36yAxLyR85v5yfiH/6SSRdI9cYIcrXbL8OJnUPum049CW2xaAH
         LbTGGfjb8KcSMqzydXZaqqpPmDQLqwWPhQHKuBxqvC3+lnz1AAQMvf4VYvizPPeGRpzS
         w0GpEbFTtj1MSiZU1kTolm2tvhGrgdO7bjqmGUsckfP+T596bqkWhQoNB1/SmCTlDaJK
         XGQCYOb1DeuHTuxJWYiBh315tXjjO0mQBoSvEXCq2JfhHRj1SG5N+6r9bEnpqNPD1QXs
         TXxdf/RW/fKzEyMus8DFEshgaFf6kB+hJTxZIoGVArYp61Y3AQfJ/qkZiMTJE7geFy0L
         90Hw==
X-Gm-Message-State: AO0yUKVnHwXsLS6IPjoQZzOdGvv+ehJD3McjMTHYbxmgZa5UTjv2cPoL
        gzVh+TSf+SfaopEJkYklpEY=
X-Google-Smtp-Source: AK7set8BxNXhFAVKHvK2fHTIQjH1bZuYU0k2nJwhsnf3eDr7OoMrK78TqRcF1fGuAweMvGYNm+tDlA==
X-Received: by 2002:a05:6a20:3aa1:b0:d5:9216:9182 with SMTP id d33-20020a056a203aa100b000d592169182mr15892420pzh.9.1679327280509;
        Mon, 20 Mar 2023 08:48:00 -0700 (PDT)
Received: from [192.168.1.36] ([117.255.22.226])
        by smtp.gmail.com with ESMTPSA id a7-20020a62bd07000000b006222a261188sm6549004pff.62.2023.03.20.08.47.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 08:48:00 -0700 (PDT)
Message-ID: <20df2a0e-def9-632a-865a-1b6569071f76@gmail.com>
Date:   Mon, 20 Mar 2023 21:17:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [ PATCH v4 1/6] sign-file: refactor argument parsing logic
To:     David Howells <dhowells@redhat.com>
Cc:     dwmw2@infradead.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, sshedi@vmware.com
References: <20230221170804.3267242-1-sshedi@vmware.com>
 <3755243.1678810894@warthog.procyon.org.uk>
Content-Language: en-US
From:   Shreenidhi Shedi <yesshedi@gmail.com>
In-Reply-To: <3755243.1678810894@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14-Mar-2023 21:51, David Howells wrote:
> Shreenidhi Shedi <yesshedi@gmail.com> wrote:
> 
>> +		{"privkey", required_argument, 0, 'p'},
> 
> Please don't change the flag assignment - you can add new ones, but don't
> change the existing.  This program is used by a lot of scripts.
> 
> David
> 

David, thanks for the review. I will address the issues and send revised 
patches soon.

--
Shedi

