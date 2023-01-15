Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0712366B266
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 17:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjAOQET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 11:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbjAOQEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 11:04:00 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7DE10A93;
        Sun, 15 Jan 2023 08:02:10 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-15eeec85280so5900191fac.11;
        Sun, 15 Jan 2023 08:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VMnzSW0XLPeyCjgGTQn71qzWUvvNevNqCs719TrkPa8=;
        b=h0UTwYec8paL/h7KPo5kkBueb/TR3PnRKDrarSy+BfCxz7pyrsUFh+U/RTaEcygno2
         7VhLjfk31w69GfW4r1D1Eu+NICxAPO2LsrUvVwdaDi0p4qeK2d1xYrmA3ZFuocnzfVKi
         B02aVrf3CzUwBTfVvF6PnyYX6C22viFPm2f9jEXhYcure45jJAYyzHQLS6v1qqd7mMhp
         FfSM/ZYvhQn2+suKsRK9PuDrtGH4PcGVLOA0j8qIBFuFyPhxNTzHjEb2XTxs+rau728n
         k3IpGwzxA402t085YAI6rqZ9hT79ldH/0q/15GcefKdqONeS7hb0/cDLHKEj7HDBDTNt
         RqfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VMnzSW0XLPeyCjgGTQn71qzWUvvNevNqCs719TrkPa8=;
        b=XRes2vs3R5rA9h9Emiibdpei3Zk4gza03iacbhQmuidqthFUX4H2Rc9PWD4RkIFvct
         hQt8xegONmt5Zg5UN6EOj1lB8lOq0MPawVxj/oVUfwSFxwLg8iOj3H/zx3CkJIV8Cc+5
         pKRdkItS0U3oN1ZOYQSbVkTkcKvtpmhzDH/Zq+gcupfQFx7GgQA9Gx1idaOEH9KQj5wU
         93Q84lEuCrc+r/ynPHAIbAqldGCAG7eYmOTbPhXF+jCquSsDOeuME0jQ3z3YC0RrVqwq
         BQecMyjXrTBM1QqtylF56giKqjp5qskXJcQJ/fLy1VUZob3jtLNH+ttUjXF1crjMOV1Q
         AGqA==
X-Gm-Message-State: AFqh2kqeS0XilWI+5ew7/Pj889EsRPzAIDSnPBGlRQ3STOnAirucH4vj
        J/9WvpSpPkLMrQDL/jqtZUM=
X-Google-Smtp-Source: AMrXdXsjO6bbSiuf1TBwntgsdZ/WjVKLnAON84ftq2XJLaDYn5zDuLEKbx+7Bq1cwuGnzeMxS7woPQ==
X-Received: by 2002:a05:6870:3123:b0:14f:d036:fd6 with SMTP id v35-20020a056870312300b0014fd0360fd6mr35244231oaa.0.1673798529568;
        Sun, 15 Jan 2023 08:02:09 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s23-20020a4ae557000000b0049f5ce88583sm12211328oot.7.2023.01.15.08.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 08:02:08 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 15 Jan 2023 08:02:06 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: (emc2305) fix kernel-doc warnings
Message-ID: <20230115160206.GA1245627@roeck-us.net>
References: <20230113064540.20179-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113064540.20179-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 10:45:40PM -0800, Randy Dunlap wrote:
> Fix kernel-doc warnings:
> drivers/hwmon/emc2305.c:62: warning: Cannot understand  * @cdev: cooling device;
>  on line 62 - I thought it was a doc line
> drivers/hwmon/emc2305.c:89: warning: Cannot understand  * @client: i2c client;
>  on line 89 - I thought it was a doc line
> 
> and drop ';' at end of each struct member line.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-hwmon@vger.kernel.org

Applied to hwmon-next.

Thanks,
Guenter
