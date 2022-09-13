Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E7F5B78C1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 19:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiIMRtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 13:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbiIMRtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 13:49:00 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4867D72B79;
        Tue, 13 Sep 2022 09:47:38 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id q63so11846440pga.9;
        Tue, 13 Sep 2022 09:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=D4rCZb+iPS0AAktlhveT3fs/5yKc7ISq+k7dnPQkKd8=;
        b=i8negqvLt2R8KY9w9wqi8vPztcyWrrqzIDzd986MVmmejKXk+ZolzF2/hHu262RRp/
         qk8vMQrop9oXkM0t4gW6Rs8K48C98tIeaZHo9YP1pYT6c0LszhdLx3n4j9x4eP0BGUfN
         KCvuNrn6lycRZ7Zxp/1levOSrHO1xGC4m/t/AUAE3WKx6XsmHrlaBd46LdlpXz1tvNcC
         xdi8b/OAVXQ2Fw4bkihwlxUZ7Pt0nvUxaHg0VgTmbU/7TedpkpFGPRcuyW0jA2/KXZ9r
         MzzcFhEq7AoEzTbN/WHxSoQ+w4tu9eVG/o1Xv7gQ0LEUgp9tMQIAO1DPp+59dwZzTwtv
         3B/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=D4rCZb+iPS0AAktlhveT3fs/5yKc7ISq+k7dnPQkKd8=;
        b=O0wfJVPdc2ufgL++OXBn2dhN2u1eXmSF7Yjyx9Wubwe0Axdu8OcYmMaGPJqUcXa2Nz
         z4g12RPS8AtpcHpFfe794UF4B3iVG4dd4i5W4gsNV1QgNrkEUvzdw0W0n01wzFStBdZN
         v0zmUZ9nTSp2V+KsMjB0A879I+RRcewjYtXIsXnZDt11pTJDYexxIWcN3sOGGvfDnwdZ
         pB6k23elv/aGM8MOU77V/1tE6EIOzKHfnFjFcWJl2deVeePgm2QjlnqroWtsXbuKkJNX
         +Xzm02/GBo8QrFM2jNCu9OHmvuq5QZdMQEA1kFCLvbfWaVOTqP0yXgHy9pY//CqeBNoo
         Xfkw==
X-Gm-Message-State: ACgBeo3Khge4nuMuF+Pz8ND/DYi8i2iBWtttlUtbSTW+W7iIztGlVFak
        GJ0Y5beaVUY3au7J0ufEv20=
X-Google-Smtp-Source: AA6agR6mbUfC1D8cN9Gdd5dsjJkDKpBLm0fcx8aLbmjjlBsidfHoaeLzTUFZ/3oIbTrFu0TO12p4UA==
X-Received: by 2002:a05:6a00:2404:b0:53b:ea5:ea4e with SMTP id z4-20020a056a00240400b0053b0ea5ea4emr33640816pfh.11.1663087657783;
        Tue, 13 Sep 2022 09:47:37 -0700 (PDT)
Received: from rog ([2a0a:edc0:0:701:a220:c777:e1f2:5de1])
        by smtp.gmail.com with ESMTPSA id s18-20020a170902c65200b00176d8e33601sm8518657pls.203.2022.09.13.09.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 09:47:37 -0700 (PDT)
Date:   Tue, 13 Sep 2022 18:47:27 +0200
From:   Philipp Zabel <philipp.zabel@gmail.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        catalin@antebit.com, travisghansen@yahoo.com,
        Shyam-sundar.S-k@amd.com, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 3/6] acpi/x86: s2idle: Add module parameter to prefer
 Microsoft GUID
Message-ID: <YyC0H7QhKl96ihwJ@rog>
References: <20220912172401.22301-1-mario.limonciello@amd.com>
 <20220912172401.22301-4-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912172401.22301-4-mario.limonciello@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mon, Sep 12, 2022 at 12:23:57PM -0500 schrieb Mario Limonciello:
> OEMs have made some mistakes in the past for the AMD GUID support
> and not populated the method properly.  To add an escape hatch for
> this problem introduce a module parameter that can force using
> the Microsoft GUID.
> 
> This is intentionally introduced to both Intel and AMD codepaths
> to allow using the parameter as a debugging tactic on either.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Philipp Zabel <philipp.zabel@gmail.com>
Tested-by: Philipp Zabel <philipp.zabel@gmail.com> # GA402RJ

regards
Philipp
