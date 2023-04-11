Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230AA6DE594
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 22:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjDKUT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 16:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjDKUTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 16:19:25 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564FA10F0;
        Tue, 11 Apr 2023 13:19:24 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id e18-20020a17090ac21200b00246952d917fso7703880pjt.4;
        Tue, 11 Apr 2023 13:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681244364; x=1683836364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QunOTwi4vxJ0GcgDU5l3kUo0rekX99CWN1S0YtmXiis=;
        b=ZSWQpqyrUexvc19A8466SMrlW9pCJQ8TV6Tu72cWpEf48Z3sf4DQAMjpzfSXeH4rup
         rH9NKTf23k6IEeZqXQhDUsxjiJNhktavB0XYouOMbmzAxiD4MkGqYcQJJvL7ZpQZ6ZbI
         pkrTzmFAcIKj8WcetYcEEFkQihH+Yy+BzX+GkjUK+bEo1+IqbTGsdMBK3lpxUYFtruO3
         vyKnn2WoqUvCGkaV++habJBJAFC9eLUmCW1y9RwxHi9it+jp7/744PvqrbmJ+lF0BlB7
         zk5sGF7gj8qegUya+/KWLDKZoJj7l1STeEH4PCco9haEGQk9JggMIvG+GhfRJXhUmtnu
         ggEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681244364; x=1683836364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QunOTwi4vxJ0GcgDU5l3kUo0rekX99CWN1S0YtmXiis=;
        b=Km5spkdooW656P6WEGvfVXXOLbA+bAopJ0COqK3rUh8yRK04BGi1VWCe+SWNaR8Bxe
         dnD+1SZd7TQNd/9pr3wDKwQfBNcXHtdOtONCvI5KMfkRjVtgqJ0N3+LSTQ4/IliSiWiy
         wQ1TVp5W9m0J/9XCgGEPuNzxEhCxeOhmL945y207xl2itzhLrLx6t7sQDYkluvXMdfPJ
         EmWCh64a1O8q29dSYM5Y0JH8o1JH/3mxxAtPS+7wAap9qUwTDkRXbRTEmrBiuatpTaCe
         ZxxfSIPLjJ6l58N0BgOWAtYqM1vUHeMmsq+JlBeSMoFOGYb06W55KP4Eih5SseaE4vjW
         /kAw==
X-Gm-Message-State: AAQBX9eaDobLBkXb8GGG75r29oFeajLyzNMXV7EeboJpEszrtnWExivV
        3E6dQJFYq6bu4Y2TB3lhiKQ+gub3vUI=
X-Google-Smtp-Source: AKy350Y8uN2hUL/4s0/Q5T5l+tiTAGKaeY11IRZixzC45IRNcQ0LqdoGB9lmYJmrJ7BtfBLWUDMLVw==
X-Received: by 2002:a05:6a20:4e14:b0:d9:a792:8e3d with SMTP id gk20-20020a056a204e1400b000d9a7928e3dmr14108477pzb.30.1681244363652;
        Tue, 11 Apr 2023 13:19:23 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n14-20020aa7904e000000b005d6999eec90sm10224064pfo.120.2023.04.11.13.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 13:19:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 11 Apr 2023 13:19:21 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Aleksa Savic <savicaleksa83@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, Jack Doan <me@jackdoan.com>,
        Jean Delvare <jdelvare@suse.com>,
        Leonard Anderweit <leonard.anderweit@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (aquacomputer_d5next) Fix alignment of function
 call params
Message-ID: <07419415-3087-48e6-955a-b5024d943e07@roeck-us.net>
References: <20230409183549.12683-1-savicaleksa83@gmail.com>
 <c24a071e-b191-4626-8edc-1658a01d80ef@roeck-us.net>
 <5f24cb94-d7f1-f8b0-71f0-2b39a89bb2dc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f24cb94-d7f1-f8b0-71f0-2b39a89bb2dc@gmail.com>
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

On Tue, Apr 11, 2023 at 08:26:32PM +0200, Aleksa Savic wrote:
> On 2023-04-10 18:53:08 GMT+02:00, Guenter Roeck wrote:
> > 
> > I am not sure I understand how this would improve readability.
> > It seems to accomplish the opposite. Sure, I know, checkpatch --strict
> > complains, but that is still better than unreadable code just to make
> > checkpatch happy.
> > 
> > Guenter
> 
> Both seemed fine to me, the idea was to fix the checkpatch warning.
> If it's OK for it to complain about this, plus the changes would make it
> harder to read, please ignore this patch.
> 

checkpatch is useful, but not in situations where following its guidance
results in code which is diffficult to read. I run checkpatch --strict when
applying patches, so I do notice when it complains. If I want a report
to be addressed, I'll say that (such as, for example, when people are
overly generous with empty lines). If not, you can assume that I am ok with
the report and find it more important to have readable code than being
checkpatch-clean.

Guenter
