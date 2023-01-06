Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86F8660810
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 21:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236097AbjAFUS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 15:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236767AbjAFUSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 15:18:20 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0BC3C72F
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 12:16:48 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id p24so2779437plw.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 12:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1b6+blSlpi+vjWL3mlCiVEuXXYZ9HziUUNoX6P7j9pQ=;
        b=MCtmreOLU5QCMBqwsT2/cEYO1O44IiNbm7FquCEv/AJNLZK4Im4+rNNJhU7YFQWH6d
         bc6m697Hzua5lJ/yHQWUaXemsdbIiMDlQyDj1UxLNm5oR/VcdeyRhexA5TC7zlq+JF8F
         AmMLDDL2CB1hk4833Wayj5hxPTr4Y/aG/efWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1b6+blSlpi+vjWL3mlCiVEuXXYZ9HziUUNoX6P7j9pQ=;
        b=z39oBV9x+qeyvV4m8rro0HA2+U2npU7W6ifPkpfDrCkB26+XyEL+gDzaRqdt9jKqKC
         YWj5iPRqX9J4VedVnsoLaCTliWtETiF9inOnPgZgORObVxqUpVt+yMEqP/zUJzXHpB/O
         34o8L387X7fBzGXiSsVxjNLxJirO1p/svWwR+ThcIpQ3pfAmV2OpqAE2fsxE+ZWppyl7
         N3IJNmig4WShJRG26tuTb7XBuX4B+35YdZrClfZC3eaeIZZU/BojbRs+V6FjIVzJsKs1
         iXTK3+7y7Qpr5sPBwnZLTvERsczLQi/LHVAqiL+ByCuqFpRmowgl/UsOVsEOb002+wJV
         q9hA==
X-Gm-Message-State: AFqh2kqu6yust8uUUxVPYrGc1iCxYPKD0gWyr0dxh68n+A+BD6prwbhq
        sLxApKPY7mZl+k1/Ieo03xLjYw==
X-Google-Smtp-Source: AMrXdXvEQUB+SHjyv+f+FLqNC5eWY7MGc+kAWkCHhMaiIWmPE5/w/2GVdE7kgZq5+jWOXkYnNP+bKg==
X-Received: by 2002:a17:902:e0d3:b0:192:e0f1:b166 with SMTP id e19-20020a170902e0d300b00192e0f1b166mr11349346pla.27.1673036208241;
        Fri, 06 Jan 2023 12:16:48 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id iw21-20020a170903045500b00177fb862a87sm1375696plb.20.2023.01.06.12.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 12:16:47 -0800 (PST)
Date:   Fri, 6 Jan 2023 12:16:47 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        linux-bcache@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [regression] =?iso-8859-1?Q?Bug=A02167?=
 =?iso-8859-1?Q?85_-_=22memcpy=3A_detected_field-spannin?= =?iso-8859-1?Q?g?=
 write..." warnings with bcache #forregzbot
Message-ID: <202301061216.CF08E5E2@keescook>
References: <19200730-a3ba-6f4f-bb81-71339bdbbf73@leemhuis.info>
 <2e4e65a8-87b4-fac6-ef89-76b118b0cec4@leemhuis.info>
 <202301052218.042D2BFE@keescook>
 <f1ca3cea-01ae-998a-2aa8-c3e40cf46975@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1ca3cea-01ae-998a-2aa8-c3e40cf46975@leemhuis.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 11:57:46AM +0100, Thorsten Leemhuis wrote:
> In that case I'd suggest: I forward any I see to you, but don't add them
>  to the regressions tracked with regzbot.

That would be much appreicated; thank you! :)

-- 
Kees Cook
