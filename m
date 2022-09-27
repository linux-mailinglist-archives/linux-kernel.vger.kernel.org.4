Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D9C5ECC1F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 20:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbiI0SZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 14:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbiI0SZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 14:25:18 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59A8CF4A2;
        Tue, 27 Sep 2022 11:25:17 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1318443dbdfso3026473fac.3;
        Tue, 27 Sep 2022 11:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date;
        bh=V8AR0AQTHj331AufhAAOfkfNIqY+UnJZGtLIqtaVqTA=;
        b=W/XvcQy/YQ67MGkoPyNIksQ319UiWaGd54efdpjvkcFlj8zUCL2KauPSY2AOVMQrTR
         d6dliedIL+KH4foKRbsLPgHp3+9YVxhK79mufaBqexiI99cAJlQhmmV2M+2N7AGarDSq
         6NJ2x3HuuURKXWJHg7Aot7OWcMk+ZUKzY+N4wqMRiZ7DdpEhMN8HcC9/09o2fJWrqCyF
         e5tdG0ZIhIfu2hP5Fz53Bfh40WLy0hUcpMIlGN3igymiaw/eq+Aji+/Trj7wfmYlOkt+
         hZD7KYa6AM+Mr1tAPFross5H7TPhS0chbzHTA92h5NjN6V80SNjtFDmzjvECE/4ZGcEw
         imrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=V8AR0AQTHj331AufhAAOfkfNIqY+UnJZGtLIqtaVqTA=;
        b=qwg8xxEcdZVIK3e3zj31lqaEKdWRytmBVMZ1G2oP19O6/6XcueGllhUoLTHlr4uUe+
         6M2NZKdKpKH0lrlUJagVZ8wxvBOnYNWr1SfZSQhLrneQPEWWfoA2O8AUNi2G7Af4ytMA
         ZMQGMYDDFK7zvAJFz4+A9KzUGoCvpI5k7ZRBOmjEkdidnJF+q6caXjrB28YpdQAkqLwI
         YRFasycMPHCEmWexZti/pLfv9EDSL5eXoZw0IClQMo3uObRrvcBzmCarkvn8O4uW47N3
         gZKXLjDnQsapTY4rl1zSaXA/IvDlwHEhpwjVi+ztDNPk+s8dNmfpo9zgyWwUGriMKL8K
         bIFw==
X-Gm-Message-State: ACrzQf0P3GsWUIF+6tj4zLXeQM+boqeHdzm6jqknlBPsa92AIjaR+5ig
        PUFDxGupBEFzT/4YXKCazKGibaMRhM4=
X-Google-Smtp-Source: AMsMyM6hQ+AxwuPg1EcwScCIIHb/Y6g0rVCX9WoO/vj+pqVnVUrv6BP9pgoOuaukvUeLgWEzASvkWA==
X-Received: by 2002:a05:6870:160c:b0:12b:9663:67ca with SMTP id b12-20020a056870160c00b0012b966367camr3075949oae.36.1664303117085;
        Tue, 27 Sep 2022 11:25:17 -0700 (PDT)
Received: from [10.62.118.123] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id y21-20020a056830109500b006391bdbb361sm1005166oto.31.2022.09.27.11.25.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 11:25:16 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <93c93732-70e8-ad8a-bb2e-a5da315742e1@lwfinger.net>
Date:   Tue, 27 Sep 2022 13:25:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: Problem with modprobe
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
References: <6c1ca180-8df7-c4d0-bd9f-d6b70f6c5142@lwfinger.net>
 <YzM0Z4gXsjZTDkX0@kroah.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <YzM0Z4gXsjZTDkX0@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

On 9/27/22 12:35, Greg KH wrote:
> I don't think we ever auto-unload dependant modules as we don't know if
> they are still in use or not (hint, module references is not a
> representation if the module is in use or not.)
> 
> So this is working as intended, right?  And how it's always worked?

Thanks for the explanation.I will need to document this behavior and explain to 
the users that it takes two steps to unload. At least the load works correctly.

Thanks again,

Larry

