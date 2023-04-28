Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E9E6F1D52
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 19:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346430AbjD1RWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 13:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346392AbjD1RWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 13:22:45 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB92E4EC7;
        Fri, 28 Apr 2023 10:22:42 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-3ef49c15454so726201cf.0;
        Fri, 28 Apr 2023 10:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682702562; x=1685294562;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AAiiv9GsxvY8biLmdAscKWHe+NudNnl/0EZJjn39MN8=;
        b=ZLl+Ok+qlmf88oDwoCLd4n3mf8DUZyFA12liJOivOE9QAh6PozBMDc0nQ8vMhgix8c
         2pxr+fz01ZcGEGZ/Wzz+8Fd/CbiH/PpHbrPIIcc0+V28CR5+TnqHl6h+4SHWdXK/QwNu
         zsz9hjOhQBf1EZmH6a5TIAmyKfH2o9lNvWQoSeHMlC5vuaZ5BIL5yANHvphpo/1R8wKx
         BnRwK9UbG8kFdrBHvAT64LMdAM2RmZbrcduD/qBsXeagddO+wX8JFKW/nYpAhlsjjvy3
         6mPO2hAebWYjZrE5qoUxqO+X1iHuR6h+5Mntf2d2fdDOCjRWqz+emA6q1sv9V4rxAnYo
         VcUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682702562; x=1685294562;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AAiiv9GsxvY8biLmdAscKWHe+NudNnl/0EZJjn39MN8=;
        b=QCALr4d0YMlDH0o7s8/Gh+L0rojyW37qJ8EiTqQHXnIET3arz1HAeHqnMSnHah3u0y
         ynrsUCM6pA08fPY7P95cGNBpb3Dn/9kWzlpDW8CLhf0dFL42bG7MzsGpmG/C2OWEJ8Mc
         XMSGfoSRFxUokKZmgSbS5JZDuwdgZXFLgaasuRVXVEZxt+5n12hFCfLcO8bPiYJLG77h
         MAx1/pJWLscYsJk3xQOuC/LV7vrlOEcTe/eerLu0gYuhde379w9tYF61lF6NVVHkz5/Q
         XvVGnJ116vUMKNOdXtsOpaZnCl35w9+ZZea8srDmAbq3M9imS4pSv6ntFVO9zenRtjDm
         V1qA==
X-Gm-Message-State: AC+VfDwAPx0NXxRxaAo4Qyk7V6icEkG/bFLA7SsOYwMcx99Hv9HSFe6d
        ndayXjLpaetYsJ79Q5XyX7E=
X-Google-Smtp-Source: ACHHUZ6p1oLq98ooWnU/CgTxQZ4bd6HPSPRfojYddHilL+gAML+8D2BODYINVNuUN0yExpMdu7og/A==
X-Received: by 2002:a05:622a:1819:b0:3ec:47d5:ec65 with SMTP id t25-20020a05622a181900b003ec47d5ec65mr9562526qtc.60.1682702561936;
        Fri, 28 Apr 2023 10:22:41 -0700 (PDT)
Received: from [192.168.12.239] ([172.56.185.106])
        by smtp.gmail.com with ESMTPSA id f15-20020ac8470f000000b003ef33e02eb9sm7195198qtp.83.2023.04.28.10.22.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 10:22:41 -0700 (PDT)
Message-ID: <6a3d7b4e-7350-e52a-6139-e14eb64191ed@gmail.com>
Date:   Fri, 28 Apr 2023 10:22:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [RFC PATCH 3/3] Revert "input: gpio-keys - use
 device_pm_move_to_tail"
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Gergo Koteles <soyer@irl.hu>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Saravana Kannan <saravanak@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
References: <20230427221625.116050-1-opendmb@gmail.com>
 <20230427221625.116050-4-opendmb@gmail.com> <ZEtP3uRX5Ib1W_Kd@kroah.com>
 <CAJZ5v0jFAkBUAhNj8hbpM+6n1F3ETTtpxeP_QDsmKWdE=uueFw@mail.gmail.com>
Content-Language: en-US
From:   Doug Berger <opendmb@gmail.com>
In-Reply-To: <CAJZ5v0jFAkBUAhNj8hbpM+6n1F3ETTtpxeP_QDsmKWdE=uueFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/2023 4:40 AM, Rafael J. Wysocki wrote:
> On Fri, Apr 28, 2023 at 6:47 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>>
>> On Thu, Apr 27, 2023 at 03:16:25PM -0700, Doug Berger wrote:
>>> This reverts commit 2569873096f7eb1acf63624e9772d82b23923bf4.
>>
>> You have to give a reason why you are reverting it please...
> 
> Also, the commit ID above doesn't match any commits in the mainline.

Apologies. I attempted to explain this in the cover letter, but as 
anticipated it caused confusion. The relevant text was:
   Both commits shouldn't really exist in the same kernel so the
   third patch reverts the first in an attempt to make that clear
   (though it may be a source of confusion for some).

This commit ID is the ID of the first patch of this set in my tree. It 
slipped my mind that of course that wouldn't be conveyed through 
send-mail :). D'oh!

To be clear, this is really a "straw man" request for comment with hope 
of finding a more elegant solution to the issue.

Thanks,
     Doug
