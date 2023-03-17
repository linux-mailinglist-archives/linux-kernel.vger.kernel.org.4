Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1846BE7F2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 12:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjCQLWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 07:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjCQLW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 07:22:27 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D2115C8F;
        Fri, 17 Mar 2023 04:21:57 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id h8so4936796plf.10;
        Fri, 17 Mar 2023 04:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679052117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E78nJAaJHQoaQexbDXvi3+hTf5R/PEar9dE329mRMXE=;
        b=B4c2SndqL02wDBS7Gus/lAODPuw0m6nrxunVHo6Mh2s0bR0gqlXZjjEkwkUlsCLudY
         6VPT/4xXjyWFF/F48eLdTIjnVZxK4HvQ56DpW8hrW13XikCwHNAPWJCIo02s0GlNCR7N
         AyPd0iiCagHDWb+TJ8nF7xhBt248J9ZMTRMOunEyEWJzDsEgIqQXrpeR6R9soy4I6Tbv
         AZzc7L/973+uK8bh/y60qI0/VHL9x3I54stcKLF3V02IR2ltehCk/zXnPFNljrKmaO8k
         1W4t7kzEVIBlXoNF4z2ifr+lCjEmW0HeFYxrP6IK/DsI0od5WLe0+6AwPcKI63FOVHRO
         E2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679052117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E78nJAaJHQoaQexbDXvi3+hTf5R/PEar9dE329mRMXE=;
        b=zu5yBdZUA7rH2aiktAe45ioYc/+kplqyC+XWf0TMGhhZSzzZ+rMxQlEFfhw4yprcUH
         rFrz3ofcBVcDRI0iooaS+EEhlmZh+2phY6+eD5omuZK/3ROqMAXnVQZcDV2DAYOS8PUW
         z95fIJ6Ds+7KuHtel3BhaukEG3J8ms5Yn5OchUJ6lB6YKLkdhKiLCVuRlLJFmNkXquwH
         s7fa2E7t109kHBoXaWyc45zoX1lyQ0BZ+oHn5aijvM4as6PMB6sCKmoZvAhNxa7R7Jkd
         C0/P0MMqiIGVyl3pQa/sE6hg2ieEl4iX8vKhtx+LLE1Q4+4mg5tmO0851r/X5+Vijh7w
         ibww==
X-Gm-Message-State: AO0yUKU5a5RMbInUgSx3HRPAwVfoA0B5WpzjeqSxKRJ3bf/MkTZn/bWR
        eGJKBu1OOUDvlLAWbE3rmn/DU2pJRDeKmw==
X-Google-Smtp-Source: AK7set+BbTq7KNQfkHvoRNW986M6GK7lHB6U6IaWZOL98sAWOUJwSmf2ryuzwTt8SXHOJJAgjmOSmA==
X-Received: by 2002:a17:90a:355:b0:237:24a8:c5e2 with SMTP id 21-20020a17090a035500b0023724a8c5e2mr7519544pjf.40.1679052117267;
        Fri, 17 Mar 2023 04:21:57 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:d084:8252:e846:af61])
        by smtp.gmail.com with ESMTPSA id jn15-20020a170903050f00b001a04d27ee92sm1321780plb.241.2023.03.17.04.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 04:21:56 -0700 (PDT)
Date:   Fri, 17 Mar 2023 04:21:54 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: zinitix: Use of_property_present() for testing DT
 property presence
Message-ID: <ZBRNUt9y+25v0Bw3@google.com>
References: <20230310144708.1542682-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310144708.1542682-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 08:47:08AM -0600, Rob Herring wrote:
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties. As
> part of this, convert of_get_property/of_find_property calls to the
> recently added of_property_present() helper when we just want to test
> for presence of a property and nothing more.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied, thank you.

-- 
Dmitry
