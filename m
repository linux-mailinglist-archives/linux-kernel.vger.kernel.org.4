Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD535612693
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 02:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiJ3ASS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 20:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJ3ASQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 20:18:16 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CF92496A
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 17:18:15 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id 4so7936775pli.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 17:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4sHJ0uGd/0eErR7PFl+RWk3gHbczSzplTSSzCUNeA0=;
        b=R7Wd1HAdnpJLmQV5KnlPADGVDhW9cx+2kssOQqpcdj0HVLpgNjeBGUm9yzOk6sRYqn
         v7CZDsUFBpv96deaCFh1uJ/wJA2d/kuUC4q2/GBU6ABwyLekOsZVCaVtHVUx4yOKc5vA
         99aQ/ExYfiS43hXg2JgI41Jv1RWO5Jml5GatPEyizaz1J6eCIvAkQzMfrLNk99HX5Ete
         W2CvjGVi7Plu3/7hKjewYD9ZwpJ3EVvln67UzTFoYMoJJn9rhwvuq6Mb0XnYJurG0OSy
         O6TEoscgTs75fWm8KG7xOo1tbVtRNFPiSthNF3BKEk63VbD4eUl5z92xqhvsUYg5+o9C
         xTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4sHJ0uGd/0eErR7PFl+RWk3gHbczSzplTSSzCUNeA0=;
        b=RHWU3XG1zY4r6epq2yd0OJpw+RnjbgSPvhVm3CSohnkoVY13s3Q50HjHxePyVDFQBD
         XqicMZ3chpJ8HlKOWLNmVPaAQgn18h0qO/60xYAtZbwjyV1SfmlGlTXv+k4GxSPK37dG
         KQnZ6tNRjTXGK3KZoD3l60t9XV9DReN3yvpP3WJIJvB0UILcb7PrO0MwtqKt15zDzey7
         wKAFvOmJ3j3Z/cJ9gCpnj9HreDIdi2xkzFWnKql+MKD7MFwOEb0KERlmD0KZhIaVY2Zw
         gsKRMqzFWlK/qyBDf/I0877ldMOgvVO9aW08duvMyYXysyBDSmrcJhneDk3GyGuhZe1u
         MW1Q==
X-Gm-Message-State: ACrzQf1vmqGEhWmGpnx/PgNA4BysXkJWDxtDxw9Jo16AxJCHfGobGfPj
        URgHlmJnFNqSZj1lJXMJHPk=
X-Google-Smtp-Source: AMsMyM7qXCkaYsDCqrcnjZe1gY3PJa48GtM5mwq14jkA4b31e3Fkh5lBfq3p77IY2esHXLpMCm72BQ==
X-Received: by 2002:a17:90a:7e14:b0:210:dcec:ffe9 with SMTP id i20-20020a17090a7e1400b00210dcecffe9mr7161179pjl.157.1667089094410;
        Sat, 29 Oct 2022 17:18:14 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id g6-20020a625206000000b005633a06ad67sm1714897pfb.64.2022.10.29.17.18.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Oct 2022 17:18:13 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 01/13] mm: Update ptep_get_lockless()s comment
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <CAHk-=wgiDa9Xy5rLMR_gvC-WVvdkxABgXXADbKhwswYof7ptdg@mail.gmail.com>
Date:   Sat, 29 Oct 2022 17:18:11 -0700
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>,
        John Hubbard <jhubbard@nvidia.com>, X86 ML <x86@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        jroedel@suse.de, ubizjak@gmail.com,
        Alistair Popple <apopple@nvidia.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3416A651-E648-4A2E-A710-21163F9537EE@gmail.com>
References: <20221022111403.531902164@infradead.org>
 <20221022114424.515572025@infradead.org>
 <2c800ed1-d17a-def4-39e1-09281ee78d05@nvidia.com>
 <Y1ZGNwUEdm15W6Xz@hirez.programming.kicks-ass.net>
 <CAG48ez3fG=WnvbiE5mJaD66_gJj_hohnV8CqBG9eNdjd7pJW3A@mail.gmail.com>
 <Y1fsYwshJ93FT21r@hirez.programming.kicks-ass.net>
 <CAG48ez3VE+3dVdUMK+Pg_942gR+h_TCcSaFxGwCbNfh3W+mfOA@mail.gmail.com>
 <Y1f7YvKuwOl1XEwU@hirez.programming.kicks-ass.net>
 <CAG48ez05gBiB2w7bL_3O_OUoBWazmHnRwMiuni_wQyXBUcaxbQ@mail.gmail.com>
 <Y1oub9MvqwGBlHkq@hirez.programming.kicks-ass.net>
 <CAHk-=wihPdOtXgJ32pLB6Xd-UvnaZW9YvOOjM24JGYRjNHeykA@mail.gmail.com>
 <6C548A9A-3AF3-4EC1-B1E5-47A7FFBEB761@gmail.com>
 <CAHk-=wh8oi0qQtYDFTfm7d1s5C8mG7ig=NfzGWt4zbjXMzcdqQ@mail.gmail.com>
 <F9E42822-DA1D-4192-8410-3BAE42E9E4A9@gmail.com>
 <B88D3073-440A-41C7-95F4-895D3F657EF2@gmail.com>
 <CAHk-=wgzT1QsSCF-zN+eS06WGVTBg4sf=6oTMg95+AEq7QrSCQ@mail.gmail.com>
 <47678198-C502-47E1-B7C8-8A12352CDA95@gmail.com>
 <CAHk-=wjzngbbwHw4nAsqo_RpyOtUDk5G+Wus=O0w0A6goHvBWA@mail.gmail.com>
 <CAHk-=wijU_YHSZq5N7vYK+qHPX0aPkaePaGOyWk4aqMvvSXxJA@mail.gmail.com>
 <CAHk-=wgiDa9Xy5rLMR_gvC-WVvdkxABgXXADbKhwswYof7ptdg@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 29, 2022, at 12:14 PM, Linus Torvalds =
<torvalds@linux-foundation.org> wrote:

> It didn't fail for me before, it doesn't fail for me with those =
patches.

For the record, I tried to run the PoC on another machine, and it indeed =
did
not fail.

Turns out I had a small bug in one of the mechanisms that were intended =
to
make the failure more likely (I should have mapped again or madvised
HPAGE_SIZE to increase the time zap_pte_range spends to increase the
probability of the race).

I am still trying to figure out how to address this issue, and whether =
the
fact that some rmap_walk(), which do not use PVMW_SYNC are of an issue.

---

#define _GNU_SOURCE
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>

#define handle_error(msg) \
   do { perror(msg); exit(EXIT_FAILURE); } while (0)

void *p;
volatile bool stop =3D false;
pid_t flusher_pid;
int fd;

#define PAGE_SIZE	(4096ul)
#define PAGES_PER_PMD	(512)
#define HPAGE_SIZE	(PAGE_SIZE * PAGES_PER_PMD)

// Comment MUNMAP_TEST for MADV_DONTNEED test
#define MUNMAP_TEST

void *dirtying_thread(void *arg)
{
	int i;

	while (!stop) {
		for (i =3D 1; i < PAGES_PER_PMD; i++) {
			*(volatile char *)(p + (i * PAGE_SIZE) + 64) =3D =
5;
		}
	}
	return NULL;
}

void *checking_thread(void *arg)
{
	volatile unsigned long *ul_p =3D (volatile unsigned long*)p;
	unsigned long cnt =3D 0;

	while (!stop) {
		*ul_p =3D cnt;
		if (*ul_p !=3D cnt) {
			printf("FAILED: expected %ld, got %ld\n", cnt, =
*ul_p);
			kill(flusher_pid, SIGTERM);
			exit(0);
		}
		cnt++;
	}
	return NULL;
}

void *remap_thread(void *arg)
{
	void *ptr;
	struct timespec t =3D {
		.tv_nsec =3D 10000,
	};

	while (!stop) {
#ifdef MUNMAP_TEST
		ptr =3D mmap(p, HPAGE_SIZE, PROT_READ|PROT_WRITE,
			   MAP_SHARED|MAP_FIXED|MAP_POPULATE, fd, 0);
		if (ptr =3D=3D MAP_FAILED)
			handle_error("remap_thread");
#else
		if (madvise(p, HPAGE_SIZE, MADV_DONTNEED) < 0)
			handle_error("MADV_DONTNEED");
		nanosleep(&t, NULL);
#endif
	}
	return NULL;
}

void flushing_process(void)
{
	// Remove the pages to speed up rmap_walk and allow to drop =
caches.
	if (madvise(p, HPAGE_SIZE, MADV_DONTNEED) < 0)
		handle_error("MADV_DONTNEED");

	while (true) {
		if (msync(p, PAGE_SIZE, MS_SYNC))
			handle_error("msync");
		if (posix_fadvise(fd, 0, PAGE_SIZE, =
POSIX_FADV_DONTNEED))
			handle_error("posix_fadvise");
	}
}

int main(int argc, char *argv[])
{
	void *(*thread_funcs[])(void*) =3D {
		&dirtying_thread,
		&checking_thread,
		&remap_thread,
	};
	int r, i;
	int rc1, rc2;
	unsigned long addr;
	void *ptr;
	char *page =3D malloc(PAGE_SIZE);
	int n_threads =3D sizeof(thread_funcs) / sizeof(*thread_funcs);
	pthread_t *threads =3D malloc(sizeof(pthread_t) * n_threads);
	pid_t pid;

	if (argc < 2) {
		fprintf(stderr, "usages: %s [filename]\n", argv[0]);
		exit(EXIT_FAILURE);
	}

	fd =3D open(argv[1], O_RDWR|O_CREAT, 0666);
	if (fd =3D=3D -1)
		handle_error("open fd");

	for (i =3D 0; i < PAGES_PER_PMD; i++) {
		if (write(fd, page, PAGE_SIZE) !=3D PAGE_SIZE)
			handle_error("write");
	}
	free(page);

	ptr =3D mmap(NULL, HPAGE_SIZE * 2, PROT_NONE, =
MAP_PRIVATE|MAP_ANON,
                   -1, 0);

	if (ptr =3D=3D MAP_FAILED)
		handle_error("mmap anon");

	addr =3D (unsigned long)(ptr + HPAGE_SIZE - 1) & ~(HPAGE_SIZE - =
1);
	printf("starting...\n");

	ptr =3D mmap((void *)addr, HPAGE_SIZE, PROT_READ|PROT_WRITE,
		   MAP_SHARED|MAP_FIXED|MAP_POPULATE, fd, 0);

	if (ptr =3D=3D MAP_FAILED)
		handle_error("mmap file - start");

	p =3D ptr;

	for (i =3D 0; i < n_threads; i++) {
		r =3D pthread_create(&threads[i], NULL, thread_funcs[i], =
NULL);
		if (r)
			handle_error("pthread_create");
	}

	// Run the flushing process in a different process, so msync() =
would
	// not require mmap_lock.
	pid =3D fork();
	if (pid =3D=3D 0)
		flushing_process();
	flusher_pid =3D pid;

	sleep(60);

	stop =3D true;
	for (i =3D 0; i < n_threads; i++)
		pthread_join(threads[i], NULL);
	kill(flusher_pid, SIGTERM);
	printf("Finished without an error\n");

	exit(0);
}=
