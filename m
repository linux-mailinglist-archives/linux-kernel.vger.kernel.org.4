Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9213F6B6E8B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 05:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjCMEzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 00:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjCMEzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 00:55:19 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7632434F4F
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 21:55:17 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id l12so1795017wrm.10
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 21:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678683316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zp3ofHoONwt43Lfi5ZwTAJ8DiKIiYOSsMfYFCAAYeDk=;
        b=Nm5R9gRnQc6vf0SAea9CmMhuYv3czapS4TiPXvyhgD8Zi95tlnjzt7TsaWEjj9TF/c
         oY10ev9XSaq9ATQS4SxI/0UlxXZnfm/BqVRoV5JI4N05dN5J/qLYvHCOtN5u0+OpjxhL
         bNYxriKIRej1BO7rhU/2DD3+JQK8ugbZAGE408fW92MovlxwXu38ckad4Q460mcnu9ar
         vAscONzI3PjdsNQPUltNNRl5FZzJ260G0MvFBiM2S24vWMr3btjY5WBp1DqgDrETazTH
         a0cuO1DIm+xOnUJZ8DDJ3tHD2jIi4c/kHQ4AIY8MQV78MHW6+yuXxXyDLc1Dq80EWOp0
         Iycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678683316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zp3ofHoONwt43Lfi5ZwTAJ8DiKIiYOSsMfYFCAAYeDk=;
        b=nufzMAij3XkGsQXW5OwJYwcnWZi4yX3DEaOIJ9+SaVWmH6Y6cThJDE2pICuN2CG2wm
         vN9P8J9Nh+S9kNeGBuNVlXR6cX4oW4ye9OxEBx4aOELbT3h63FDf795HOxZRI8uQA4cp
         VivcethyOIizcm9cLY3nzFdHgn0KBm86aPs3V/XyWc9vxTLUcOga6ivVtbMxJFSDEj4l
         52GCYKu1o0OFWH0DMKdx+DGk9Fu4C+AP6UgpHDjbxcIV4oYK9SHZkEvZGw8+oFM1IhRM
         XUbdPmLp3K0Xc+D77cvkKRnoHaTBVCdxMuoqH0eLpWdbO0i8ZP7pq9wbR0uj9ZV4+t7r
         m04g==
X-Gm-Message-State: AO0yUKWJZcmPa8gANA5eqfNJ3ZmZy/jPV64EJXhUSxQ3sDZXVAyglt8U
        kOeuhiST8udTV2PnVwKABbXB4GHLlHQ=
X-Google-Smtp-Source: AK7set8hFYIqyB+wzu9yJz7taWP4OoxdzEHmnNVkBX3ilfZLDyXjlJF1T+tBZqELmFyLRGRvY64+3Q==
X-Received: by 2002:adf:e40b:0:b0:2ce:e571:5cc7 with SMTP id g11-20020adfe40b000000b002cee5715cc7mr1422502wrm.56.1678683315990;
        Sun, 12 Mar 2023 21:55:15 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id a18-20020adffad2000000b002ceb7a11eb9sm2249591wrs.42.2023.03.12.21.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 21:55:15 -0700 (PDT)
Date:   Mon, 13 Mar 2023 07:55:07 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/12] staging: rtl8192e: Remove unused RF90_PATH_C and
 ..D starting .._phyreg.h
Message-ID: <9da125e9-55f9-40a5-8e35-3d44062eab0a@kili.mountain>
References: <cover.1678569965.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1678569965.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good!

Reviewed-by: Dan Carpenter <error27@gmail.com>

regards,
dan carpenter

