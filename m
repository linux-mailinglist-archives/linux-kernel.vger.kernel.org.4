Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6096DF989
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjDLPQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjDLPQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:16:10 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C706EA0;
        Wed, 12 Apr 2023 08:16:07 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id p8so11788641plk.9;
        Wed, 12 Apr 2023 08:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681312566; x=1683904566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZS9yP42BKeu0nz/0Fm0spdywFD6SWet99eT1pAG4Mlk=;
        b=fmru5TWLslHh1F/VpibtInvaPjnCtBeoXL3OSKg/2tbc79Zs68W+w9FQmiu5FGkxi/
         xGqjIneCh6fJuwXILFrgBA/UKaQofCXgCAKojwRfrXLGL3xQ4y2GXG+LFLiLbvItCNh4
         W8T+q1WC0NAIYZzbQQaxFpBYsepP6NVMY0CazPMQXnywBJrO8D5b1H+ArbMNag8rc1b/
         YzQS9XZtMuuOpIpELDw97ta/XbmoIfHk7CWqGIXNhutOhRlC30VLaFXStKopgLUMrJDX
         lJnqp/Vr4w/Q77h93wzLd3xRCaDn3e4wxx6/bbTWGz8FX5xNnOnVNC/j5XNS30yi7gsg
         WKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681312566; x=1683904566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZS9yP42BKeu0nz/0Fm0spdywFD6SWet99eT1pAG4Mlk=;
        b=zS6a7xMVis33nrwSQJ7XTE0ueP7rD1SMcNP7Sn5kXwyLap42TpjmTdQ8YSwgg6Fw+W
         Ocqm12MgaJodY7WqcWFaIr/R75i4tDrLc45xwLex5YrZxVX0iIpqsQgrWwhipRktkebE
         nUA3hTTTqbHNl28mePvmzjvQaQRrGmUBZwfk2cMUegO/S4M59Op6ZEoXrxh0x+jiT6ZT
         9arDNp8efK39RbLR3Bjo+C5zuoyKivFqAxe3EQmZfxCWiaWjekouzbNKg59kiw7GMtOI
         d1lVx1NYHAta10kSk8HrFqek4+c4kl2y+GIiBlUfdEiy/UMsDW+paCdD0Xujr1DerF6u
         uyuw==
X-Gm-Message-State: AAQBX9chyw0kc1soSA7MVVjk0i/1dahR5E4GQAY9ac/ny8GHCRoCOip5
        6kcBuYlV2bwv8eVKSFuQKeU=
X-Google-Smtp-Source: AKy350Y99bJLq8uRdrtvpIRU04QHFcqGKSNe9mjACrHY6Wpowj9B+kamKE3rocfSGE80O61sCYJ96w==
X-Received: by 2002:a17:90a:44:b0:23d:39d5:f81e with SMTP id 4-20020a17090a004400b0023d39d5f81emr23204230pjb.11.1681312566441;
        Wed, 12 Apr 2023 08:16:06 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id mp2-20020a17090b190200b0023f5c867f82sm1603745pjb.41.2023.04.12.08.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 08:16:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 12 Apr 2023 08:16:05 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] hwmon: (pmbus/core): Notify regulator events
Message-ID: <fff31134-4fca-400d-8f29-ebb18fe7e488@roeck-us.net>
References: <20230328150335.90238-1-Naresh.Solanki@9elements.com>
 <20230328150335.90238-3-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328150335.90238-3-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 05:03:35PM +0200, Naresh Solanki wrote:
> Notify regulator events in PMBus irq handler.
> 
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>

Applied to hwmon-next.

Please check your e-mail settings: checkpatch complains about a
mismatch between Naresh.Solanki@9elements.com and
naresh.solanki@9elements.com. Not that it matters in this case,
but it is annoying to get a checkpatch alert each time I apply
one of your patches.

Thanks,
Guenter
