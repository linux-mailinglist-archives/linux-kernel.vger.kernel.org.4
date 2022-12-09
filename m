Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3061647B5F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 02:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiLIBZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 20:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiLIBYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 20:24:31 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FA4B107B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 17:24:12 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id js9so2266271pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 17:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y9JTmHTOPl5nDm1yqUNn/t1md053yskw0F3nV+0Iu4E=;
        b=4/uk2xVAf9F+AhylLvf7hNvXalorjC0kckBJRFq0Ukam/mK6lCG9KmEKa8n3+Ii/o9
         S8uUmzItrT3g8Zy2aX1GJJ71wgwgRde3VuP/Ndoeza3B4/X95VCOKj0WB89Kq2LTqOaQ
         5qv9c0oJlYf4VSI6z1yDnCD/O0iGV4j0P+heHepIyeV7jNkpvL/C/tFkDL0I46u5uMrx
         7YXXcvZWWwtfp6E9FN+fLNZWiPkTkWnRsrpMcNkgtptYZYpdr7XRzmiuZFN39TDGgBt9
         4PiK7o4ho9SaFv8lGBgP0BAOvHdWwtzJ19sz5DGBA7SaGPl1Wmm5AegRYcRylKbnLmiE
         t7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y9JTmHTOPl5nDm1yqUNn/t1md053yskw0F3nV+0Iu4E=;
        b=EEPujCjcpCndJGSnsRt46BvSLDSGDB7JpIxcRpV+G3LYGxMh3tAdh1K2XClBgAFLwj
         0teKOo2WTdXUKZVKPXEjBE/ciWst/Wuml+IZd3dKkbaBR/cBNPNCgWaItMWUrud87jy1
         MgTxIm3b8kT73Vt1EkmSEQzNRpSjbGzt/M2oyUQA/Hvsh7NmUmgCTxv2sQoyZ7X018Lb
         4svqxsfyvv5UEVrFEqG0bXH3i4goYnCKhZeC912+ShqOI5HoWD4FoErMRZH5r29GcuHR
         s4e/Rj+hZ+KrmSWbUWZUo8obS6lrtVvBiNQrm+6t1dCJrhhESIcE2/cYEJ47IniwwEP0
         Z6AQ==
X-Gm-Message-State: ANoB5pnWov2XJzW4jUCnuydVYC7mZJWni7kISISzGDYuw0hlmCEmt3Ya
        ixceWoq7O+13rHqg40hQ+L9oZQ==
X-Google-Smtp-Source: AA0mqf6ZBDYmBOsr/DQRLosH+OJ7jt/dIxHQQcuu5pXgirF4LnFvYmQKTT2R3sNhgPKR8SI2SFihZQ==
X-Received: by 2002:a17:90a:d984:b0:219:6619:848a with SMTP id d4-20020a17090ad98400b002196619848amr4077841pjv.36.1670549052230;
        Thu, 08 Dec 2022 17:24:12 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id s13-20020a17090a764d00b00218c5bdb983sm100541pjl.22.2022.12.08.17.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 17:24:11 -0800 (PST)
In-Reply-To: <20221123150257.3108-1-jszhang@kernel.org>
References: <20221123150257.3108-1-jszhang@kernel.org>
Subject: Re: [PATCH] riscv: boot: add zstd support
Message-Id: <167054670411.18962.4800542300432507524.b4-ty@rivosinc.com>
Date:   Thu, 08 Dec 2022 16:45:04 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-e660e
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Nick Terrell <terrelln@fb.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Nov 2022 23:02:57 +0800, Jisheng Zhang wrote:
> Support build the zstd compressed Image.zst. Similar as other
> compressed formats, the Image.zst is not self-decompressing and
> the bootloader still needs to handle decompression before
> launching the kernel image.
> 
> 

Applied, thanks!

[1/1] riscv: boot: add zstd support
      https://git.kernel.org/palmer/c/de59b6ed0618

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>
