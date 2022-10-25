Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9E960C313
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 07:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiJYFH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 01:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbiJYFGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 01:06:55 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1148C2C9E
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 22:05:23 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id m6so10894549pfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 22:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3cbUiytZCvIodwgXeI/vSOQye/5S1njVlXadTLjeUo8=;
        b=W5kfkuG9CcA/C3m5TM2kcOpo/1KQZ4521CJIcyOyRm8zLKjwmMn+EKdbKuTMp/KzNb
         YTJvxrJWMxFBBOzarTzWs74NjunhohwZriUnVGkcsBGpW02gRAU9DGwDeJrwsrcKj4GZ
         wNQmlU+IvHP61vmH74uh3tXPVuI1q0cW8wq5jP9kH8KcGH1BLQP5V86k9lyEFy+IAmuv
         9jXjmMZuJ+/eFUJoUq1OYsm9aihac/HS0rU+Ns2+TvQe81WiSzuksbPQd2Aff5fguPYZ
         C1xm5hkeYLX0CwdxWnjdMVPOCmia+nmW3LUvbvsY4YpeVaKpaKFS82VuZ5Z8z7ByQdor
         Utng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3cbUiytZCvIodwgXeI/vSOQye/5S1njVlXadTLjeUo8=;
        b=iIalShVBLoxOt2R6MqtdeX6uUBv+JyfYSGhbo6IKzuFZPh3dKKLdmMfiI7N4wIQHEp
         8+EqozLeu54oAffcLsVj0ra1Q0Db22bkXlHYmM8jzYG/v8w8lMWbchShkc6ttf2nADbz
         qKetvJTdygMRbb0dr6aR4RX3Z77lYQJNY729eIE2PlGMx5j6Lq5GaR8FmfS5cXmtrhoE
         lybmzI4v1HHdVQcvqkaKSSuKHONAZri20w2OUBpz+AgF1M3TGH/t2PEbAT0K2kYLJlo6
         RJLPtJQgItKuPQ2SSBxQZEfHRfsq4Yzxb797d5BXfrLGtv+PlvVoTdlnmfurGv7dqgHo
         neLg==
X-Gm-Message-State: ACrzQf3ojQImDHu7fi8hWVKjL0v6htQ4+Kb8uJq/UOX/vublf3+OglU6
        k8yQtgPaSNZTIxHLeuUcO3M=
X-Google-Smtp-Source: AMsMyM6rDLaRMQZqopTPhy4nMyIBeX66wVCx2ReyDNNtBNisVY5Ag5pJCDcYqccfR5ODLK/vB/5eVg==
X-Received: by 2002:a65:564d:0:b0:46b:1a7d:3b82 with SMTP id m13-20020a65564d000000b0046b1a7d3b82mr31102458pgs.459.1666674318244;
        Mon, 24 Oct 2022 22:05:18 -0700 (PDT)
Received: from biggie ([103.230.148.186])
        by smtp.gmail.com with ESMTPSA id y123-20020a623281000000b0056bfd4a2702sm627463pfy.45.2022.10.24.22.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 22:05:17 -0700 (PDT)
Date:   Tue, 25 Oct 2022 10:35:11 +0530
From:   Gautam Menghani <gautammenghani201@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, zokeefe@google.com,
        shy828301@gmail.com, vbabka@suse.cz, david@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v2] mm/khugepaged: add tracepoint to collapse_file()
Message-ID: <Y1duhy5kbhLoMqWO@biggie>
References: <20221024173559.332324-1-gautammenghani201@gmail.com>
 <20221024131706.3d58bd92c332684386c7df13@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024131706.3d58bd92c332684386c7df13@linux-foundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 01:17:06PM -0700, Andrew Morton wrote:
> On Mon, 24 Oct 2022 23:05:58 +0530 Gautam Menghani <gautammenghani201@gmail.com> wrote:
> 
> > In the file mm/khugepaged.c, a TODO in the function collapse_file() asks
> > to add tracepoints. Add the tracepoint named "mm_khugepaged_collapse_file".
> 
> This isn't a very satisfying explanation for changing the kernel.  Maybe
> the comment is stale are this tracepoint is unneeded.
> 
> Please explain afresh how this addition benefits kernel users?
> 
The function collapse_file() is called by the function hpage_collapse_scan_file(). 
Without a tracepoint in collapse_file(), we won't know if it was called or not and as a result,
we also won't know if it returned successfully or not. Also, as Zach mentioned earlier [1]:

there are a few scan result codes that overlap between hpage_collapse_scan_file() and those
possibly returned in collapse_file() such that, if we only have the one tracepoint in 
hpage_collapse_scan_file(), it could be ambiguous what callsite the error path stemmed from.

[1]:https://lore.kernel.org/lkml/CAAa6QmSKtj6T2dW1tkg5_HVj2+rXj5inOLdEzr0MkJzQxxcPXQ@mail.gmail.com/

Please do let me know if a v3 is needed.

Thanks,
Gautam
