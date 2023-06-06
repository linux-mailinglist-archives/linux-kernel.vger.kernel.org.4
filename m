Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6BE724A7B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 19:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238793AbjFFRpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 13:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238691AbjFFRpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 13:45:03 -0400
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D6910F8;
        Tue,  6 Jun 2023 10:45:01 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1b011cffe7fso30300055ad.1;
        Tue, 06 Jun 2023 10:45:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686073501; x=1688665501;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nmi/PPknLe5NcPV5GoTVPuKYHIzmi3+CPOd87Hhbxx8=;
        b=lR6wHl8n2NYWtlglWrbKCBfzt0/vRzPxgWYVbnKlNZzGrFHgRZp7jkEROqPfdo5IKl
         gjR2vue+mt7MGIso3IdwkDTehYfP6dY4kfzi7zLcuD9oYNNP7m+x/ddKHQNPXwpuN23U
         MXZr8pIptf7BAnSntsPHB3e6YvhWEEKAje39elOMy5Dr8IRqXVCu8/Xtw9Qr83pM8b8U
         +xkJUDaFUjg1Oh1y1lc6HmyrHmq0qPtRMb8y7l9ejHABQHoPL9lCDbk8Uri1SOnSE+Dv
         fIehHBFWuFKuc8/U+W3iklqQZ5ZTXm2jiJr5F8+1AtMvpFGM46SQ9NA7J+BxVRFa7tBH
         52wA==
X-Gm-Message-State: AC+VfDxJ0e2C6xQW4DXKm9SRV8nnQ7VT0LY757txVxJ8b/K8rFLppHmA
        /F9modXVOs/ldHMrWi9xeSg=
X-Google-Smtp-Source: ACHHUZ5fAcNgcADCkYRu+xZLEJI/xVmrRhz62JDO1XlAcIckIgnvK0ZOSG42WS2yq3aifD/6GR1Uqg==
X-Received: by 2002:a17:902:c949:b0:1b2:499f:674f with SMTP id i9-20020a170902c94900b001b2499f674fmr335469pla.25.1686073500922;
        Tue, 06 Jun 2023 10:45:00 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id r19-20020a170902be1300b001ab12ccc2a7sm8784309pls.98.2023.06.06.10.44.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 10:45:00 -0700 (PDT)
Message-ID: <bb8c8d9b-0fcb-4ba2-eea7-6954d8723d1d@acm.org>
Date:   Tue, 6 Jun 2023 10:44:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH blktests v1] nvmeof-mp: Remove nvmeof-mp tests
Content-Language: en-US
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>,
        John Meneghini <jmeneghi@redhat.com>
References: <20230606075443.17437-1-dwagner@suse.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230606075443.17437-1-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/23 00:54, Daniel Wagner wrote:
> The nvmeof-mp are designed to test a NVMe multipathing setup using
> dm_multipath, which was a configuration RHEL shipped. In the meantime,
> RHEL switched also to NVMe native multipathing which is tested with the
> nvme tests.
> 
> The nvme tests cover all the use cases which are testes by nvmeof-mp
> including the transport failure, see nvme/040.
> 
> During LSFMM 2023 conference it was decided it is better to drop these
> tests and reduce the maintenance burden on blktests.
> 
> Cc: John Meneghini <jmeneghi@redhat.com>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>

How about Cc-ing the person that wrote the code when removing code? 
Anyway, this patch looks good to me.

Bart.

