Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6324C5F3351
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 18:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiJCQUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 12:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiJCQUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 12:20:05 -0400
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A2410C2
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 09:20:03 -0700 (PDT)
Received: by mail-pg1-f169.google.com with SMTP id f193so10112226pgc.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 09:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=QWh/Tqk2tJQtRYQ726tnbmZWfj8cF9PavtxUc5cOs/g=;
        b=a1Z9YWTVBFWhRkZwEc29O7O2uUc+2PiDRbBY1DnlUBW5IBgeo6/nLWwLCqaRT9RM1G
         UAP56fIWmS9u+625SnAi41norZTRvX96ahjoj/TuwbRR5euZKWIfuCPRn6eLDdr2Hn4A
         3HQnCDg5IzNPtH5z9n2Z3Sy8VXm1a1EdzJZ/efrmF29n/vXnciZWRXYxOgKfzzn9Ny2q
         Vb5MJKfwIgczQ3OKCvy/KLeguaLEJc0zFAHLo3n/Eyglv7Fv/banHwPYSsX6AYctPMX1
         E1gD2bKvzUXGfz90iLGPXybVRcOghauksH37iCS6JPLnSmEH48w2UZxBJJ8AM44e1pGS
         5IRA==
X-Gm-Message-State: ACrzQf1ZOhT1ts65ZC7n06wcmKApiOJE+cQ9xo2VZtskubQxfpAWfSc1
        wdvEgQpxMR6PQjAr3FPm6sM=
X-Google-Smtp-Source: AMsMyM7Pl75fUudRdxvD9Q77QRaS6QjmkNeFmeOCUsiUn50G6uufCwKMUlPPCK/bCtmcDnzrYlIpRg==
X-Received: by 2002:a63:20f:0:b0:43c:1ef6:ebd6 with SMTP id 15-20020a63020f000000b0043c1ef6ebd6mr19550527pgc.217.1664814003161;
        Mon, 03 Oct 2022 09:20:03 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id nn10-20020a17090b38ca00b0020669c8bd87sm6263884pjb.36.2022.10.03.09.20.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 09:20:02 -0700 (PDT)
Message-ID: <bc7db586-0413-1e16-8710-bfafc9d1262e@acm.org>
Date:   Mon, 3 Oct 2022 09:19:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] nvme-pci-disable-write-zeros-support-on-kingston-SSD
Content-Language: en-US
To:     Xander Li <xander_li@kingston.corp-partner.google.com>,
        paulburton@kernel.org, kbusch@kernel.org, axboe@fb.com, hch@lst.de,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     ralf@linux-mips.org, jhogan@kernel.org, christian@brauner.io,
        jeff_yang@kingston.corp-partner.google.com,
        dora_chueh@kingston.corp-partner.google.com,
        james_liu@kingston.corp-partner.google.com,
        vincent_wu@kingston.com.tw, xander_li@kingston.com.tw
References: <20220930091401.14862-1-xander_li@kingston.corp-partner.google.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220930091401.14862-1-xander_li@kingston.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/22 02:14, Xander Li wrote:
> [ ... ]

corp-partner.google.com e-mail addresses must not be used for posting 
patches. Please use your kingston.com e-mail address when posting patches.

Thanks,

Bart.
