Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0224644E7F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 23:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiLFWWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 17:22:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiLFWVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 17:21:53 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270A63721E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 14:21:53 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id ud5so9798173ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 14:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TKkFwW/WJj63cceDkNUyxQnWr+gIBDmURWxHFL1Mn58=;
        b=SpaZqwytEC8qi/eZ9PnrcubRrrYWmbAnqRPB3LAEWHxFEOLArv4hM1q0/XQSpcWW3W
         wcfQxIdeqMmAGlxwlmok//NY9E+OwvS3BKl5awv/vAVUqP5jrIeLoNVkZ/4LZKDoDjtn
         nukIse+HPBB26iYWSVuTSwnxV6ZdBX2yln66WwGz/Nh/diIdNOR16GdT2pCQ8Pi3+M7I
         LrEIlB/ic75lBTiMOgZ39kBWRMA6dM36aBc4BqibWwTXTC6rzmUPkitF9HNZtf2qITxK
         kc1U6JTpq8BkP3OSL0v5+Xo6eMoiRmm++Ch1E/5sYJ1J974fzrAAL48zlmvfk9n06wp1
         VdmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKkFwW/WJj63cceDkNUyxQnWr+gIBDmURWxHFL1Mn58=;
        b=W/10GraKreIaz+ZHc6TqbTpdKZ7NT9usytN/Uf+h/k8YqYv6cSxzgpr7fE3LnpCx3j
         PLT0STjwoEHQNJhqWgLGhjrS2JxQLNv2yBR6iHDezDj0VGXUD+QyYdLcQtVyA4n4Gu3C
         UeyTZeXC8bmj6H82r+NoPGOXIZ0uHd0hMyHokC2qhD80Qq1WJ33IH7g69sDKpF+nBT5G
         c3VGy7OIPWT9kuG2qKdeYye48y5HBwEmHiprsaVdbECaC6Kx5dobzs8Zpmm04Wh9H3lc
         wJaw7sOgBOyo5RkUwdPVmpFH/Jhs79/XgGqUgYyfqVpU+itZ7LAsbOr01DyLly7t0rzx
         0KwA==
X-Gm-Message-State: ANoB5pm5XcWLdW72Otnu3BHZ9o7/JjZ4sh3Zh4DS69KXuqD7HUvVTRu6
        Rn4aFUsBdovPDYMRjOY6dwo=
X-Google-Smtp-Source: AA0mqf7dXIFbhf3bJV1aWUaZvfOa6XL+fDFKStzwyKljz6sQnh/HA7KNNnTX+bYZI6xVs/7A9Vni8g==
X-Received: by 2002:a17:906:e2d4:b0:7c1:532:f420 with SMTP id gr20-20020a170906e2d400b007c10532f420mr5694939ejb.679.1670365311249;
        Tue, 06 Dec 2022 14:21:51 -0800 (PST)
Received: from debian ([5.180.62.49])
        by smtp.gmail.com with ESMTPSA id g1-20020a17090604c100b0073dc5bb7c32sm7816807eja.64.2022.12.06.14.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 14:21:50 -0800 (PST)
Date:   Tue, 6 Dec 2022 17:21:48 -0500
From:   Petar Gligoric <petar.gligor@gmail.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Petar Gligoric <petar.gligoric@rohde-schwarz.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v2 0/3] perf: introduce perf based task analyzer
Message-ID: <Y4/AfA2OYtlTkKwo@debian>
References: <20221206154406.41941-1-petar.gligor@gmail.com>
 <CAM9d7cizPC3p0-Z1oYsDPofwNfZHyKYiJR5JXEcS31Q=mgzcLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cizPC3p0-Z1oYsDPofwNfZHyKYiJR5JXEcS31Q=mgzcLg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 10:32:35AM -0800, Namhyung Kim wrote:
> Hello,
> 
> Have you looked at 'perf sched timehist' ?
> I think it has the common functionality and can be easily extended if there's
> missing one.
> 
> Thanks,
> Namhyung
> 

Thanks for the input! For this patchset we explicitly decided against
extending "perf sched timehist" - after some pros and cons. Mainly we
didn't want to break existing programs (which might parse the output of
perf sched) and also the goal of the task-analyzer is a bit different.
E.g what will follow as a follow-up patch, is to show IRQs visually
pleasing intermixed with tasks to show potential sources of task
latency. This will be offered as an option for the task-analyzer, but
would be too much functionality for "perf sched timehist". This was the
main reason why we decided against the extension.

Best Regards,
Petar

