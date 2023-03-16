Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB096BD304
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjCPPMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 11:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjCPPMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:12:37 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58429C5AE7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 08:12:25 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id w9so9064624edc.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 08:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678979543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=asBS8y7PevjBy9t5aO9VO8B6knuWmZ1TaIJ9l/J32qc=;
        b=AQjEntfQnFhtxpLKwoMDGc8s2Oy6DRL8oBkuWR3Eet8xPxZzvscyr2x/y1IryhAtzt
         yqMm7MyN8ChX0fBkMMjC9RzI3gyffod2sIzIOD70Mphp+wbG0cTeHxagLzJdiqUxYaID
         vFoeoFLDMDsq1aUkXcKTCqltc3i6ZixoNdc1Y6HkldSPaJ0KliGN16jJK4ahUm7MZs3M
         8xBJe4HlfKiH0fXiA5BOVtpH26bRAws1QFstPwM5ZLElGT7dhbtE0druh9DTJGzedWn5
         fkatCrP0EwtND/HUJhEN2qZReN+3K2YvhTNpUctTV9oBJp3qNY7DqpdcygI+M9m+HrwK
         0rcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678979543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asBS8y7PevjBy9t5aO9VO8B6knuWmZ1TaIJ9l/J32qc=;
        b=gGm3EIIWVIIWhuENnftx+J9CSeN71G55T0yQMCXdf4jw40paieUzP5VueNP00ywNMb
         ycgHcHI8c+fsdWZ0eaAc9CYggfP+9hctx0+0Ma9oylJ9x6i3KXAejhgnNhl4DYOpTiv1
         30yUOrKkTyeJIgwnT2Z/WrB+OspWjJZcxXVvJ7+OTaW5hiWebaVqoEVwDxXRNifkKsLh
         9SzHHNpd5OKN00gq50sRqBB87/WZsZQvrKlnCtPcY3FZK3BO+04DVaBZDvacY8irqbLS
         bZBV7Hix5Bp6qEq21nGKPAfBecRqKXF9WYoyVAAq4dMOruyXqznhMPybgz8vfN0r52Fb
         1Eyw==
X-Gm-Message-State: AO0yUKUK1WVtwI9NDX3Scs/YNjV5pfLRL6bqPf2qiINWYWTkdqRE+UVQ
        2o9FJA40DS1FxnnIK/n8uIDQ1g9ANN5D4ORl
X-Google-Smtp-Source: AK7set9fsXThPkKIzSoBKhntPnCzx4qNSRa0kk8lDHshW4nYZusnuVd1kPTdtJmHp7HXyESIoyEw9Q==
X-Received: by 2002:a05:6402:12c3:b0:4fd:1fe1:838f with SMTP id k3-20020a05640212c300b004fd1fe1838fmr7895169edx.14.1678979543241;
        Thu, 16 Mar 2023 08:12:23 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.209.88])
        by smtp.gmail.com with ESMTPSA id s23-20020a50ab17000000b004f1e91c9f87sm4014573edc.3.2023.03.16.08.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 08:12:22 -0700 (PDT)
Date:   Thu, 16 Mar 2023 20:12:20 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] staging: axis-fifo: initialize timeouts in probe only
Message-ID: <ZBMx1O/4Z/4p46wM@khadija-virtual-machine>
References: <ZBMR4s8xyHGqMm72@khadija-virtual-machine>
 <ZBMT41g8kYQPCw+d@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBMT41g8kYQPCw+d@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Greg,
Thank you for the feedback, I am working on it.
I have some compilation problems currently. I'll make sure to fix them
before sending the next patch.

Regards,
Khadija

