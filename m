Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A3D611E69
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 01:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiJ1X5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 19:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiJ1X5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 19:57:40 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D511D3754
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 16:57:37 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id u6so6132965plq.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 16:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dL8ynURpMtdh0kmGkVrhnVStQaki4uWpAqyDuPgG8YE=;
        b=GzQMUs3Z324t8mnJ8BGeMc8+zTFpD3QpLW3anlsOhMUQ7HNardszqaYMyDcit6EYX7
         j8xi/2FQGHyrRk9CaRVY8UzNF+EF8z9xj2D3EBhhAA+HJSMpML/eT9tuFkgUJtT1JSjc
         HysWAMRNtkuoliLgGaXccxmOw+y29VixR/MJjwyhQrYQEVCH1Fl0BfwtCyo3THeVinbk
         GRykLUgZShx6y+D2Bq/ANuhl0AvymD0RUel04UfyCTO9WxLsLbRPRzod4FXHO8sUHljD
         oUGNFW2Xs6wFpvvtT/O7Zn01KbfgjkIN7sA5OFCFEtoPL3/R/CGav4CWTJ9Y7oHVtKHW
         K86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dL8ynURpMtdh0kmGkVrhnVStQaki4uWpAqyDuPgG8YE=;
        b=qhpMXfvYW8aZFrzEGzkkSSSm/Dv1FMh7Aa88lsOMXVodhdnKM7vVy8+j7Aq1tY+Iqg
         RR7qih/gBAj9d9+QzOVFYr8nUNRDXqTCfGuxylWnw8fnqy3YHVUKWow2TKFZkaRGwK25
         CE1UCvYDQ/oHFntpnEDcrZ9dP8fnZpgDVYhwzoUyx0cZMWr6ra3fmxPVogw+0dAN3J0W
         oOGljXDp5khVAJCShjy8aBePpqeT3j0pJAy/1J5QozkASPGrS/DxonOVVQqEnch9qr0v
         VZUG9tDMm41/lISbZ0lrD8Fki7FM4uGAjJb5ztsXPj+Duc2YhZtndB8yoe42TIyFmLtt
         MSpQ==
X-Gm-Message-State: ACrzQf1H/jSZmsgKyFJS14/Za4PUXqFVVNnAbEFv+JwmlLQK891T0ogD
        Hey+/cdV94ZinmEMETRB020=
X-Google-Smtp-Source: AMsMyM4dq2JCZiaeX1ZMkDakggfXQIU8/QR5KwQl779jicrVW2qJFszu81cT4MPos2VSSbWZaesFlQ==
X-Received: by 2002:a17:90a:2b42:b0:213:82b3:212b with SMTP id y2-20020a17090a2b4200b0021382b3212bmr1931225pjc.106.1667001456289;
        Fri, 28 Oct 2022 16:57:36 -0700 (PDT)
Received: from smtpclient.apple ([66.170.99.95])
        by smtp.gmail.com with ESMTPSA id a19-20020aa79713000000b0056bc1a41209sm36234pfg.33.2022.10.28.16.57.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Oct 2022 16:57:35 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 01/13] mm: Update ptep_get_lockless()s comment
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <F9E42822-DA1D-4192-8410-3BAE42E9E4A9@gmail.com>
Date:   Fri, 28 Oct 2022 16:57:32 -0700
Cc:     Jann Horn <jannh@google.com>, John Hubbard <jhubbard@nvidia.com>,
        X86 ML <x86@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        jroedel@suse.de, ubizjak@gmail.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B88D3073-440A-41C7-95F4-895D3F657EF2@gmail.com>
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
To:     Peter Zijlstra <peterz@infradead.org>
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

On Oct 27, 2022, at 2:44 PM, Nadav Amit <nadav.amit@gmail.com> wrote:

> Anyhow, admittedly, I need to give it more thought. For instance, in =
respect
> to the code that you mentioned (in zap_pte_range), after reading it =
again,
> it seems strange: how is ok to defer the TLB flush after the rmap was
> removed, even if it is done while the PTL is held.
> folio_clear_dirty_for_io() would not sync on the PTL afterwards, so =
the page
> might be later re-dirtied using a stale cached PTE. Oh well.

Peter,

So it appears to be a problem - flushing after removing the rmap. I =
attach a
PoC that shows the problem.

The problem is in the following code of zap_pte_range():

	if (!PageAnon(page)) {
		if (pte_dirty(ptent)) {
			force_flush =3D 1;
			set_page_dirty(page);
		}
                =E2=80=A6
	}
	page_remove_rmap(page, vma, false);

Once we remove the rmap, rmap_walk() would not acquire the page-table =
lock
anymore. As a result, nothing prevents the kernel from performing =
writeback
and cleaning the page-struct dirty-bit before the TLB is actually =
flushed.
As a result, if there is an additional thread that has the dirty-PTE =
cached
in the TLB, it can keep writing to the page and nothing =
(PTE/page-struct)
will keep track that the page has been dirtied.

In other words, writes to the memory mapped file after
munmap()/MADV_DONTNEED started can be lost.

This affects both munmap() and MADV_DONTNEED. One might argue that if =
you
don=E2=80=99t keep writing after munmap()/MADV_DONTNEED it=E2=80=99s =
your fault
(questionable), but if that=E2=80=99s the case why do we bother with =
force_flush at
all?

If we want it to behave correctly - i.e., writes after =
munmap/MADV_DONTNEED
to propagate to the file - we need to collect dirty pages and remove =
their
rmap only after we flush the TLB (and before we release the ptl). =
mmu_gather
would probably need to be changed for this matter.

Thoughts?

---

Some details about the PoC (below):

We got 3 threads that use 2MB range:

1. Maintains a counter in the first 4KB of the 2MB range and checks it
   actually updates the memory.

2. Dirties pages in 2MB range (just to make the race more likely).

3. Either (i) maps the same mapping at the first 4KB (to test munmap
   indirectly); or (ii) runs MADV_DONTNEED on the first 4KB.

In addition, a child process runs msync and fdatasync to writeback the =
first
4KB.

The PoC should be run with a file on a block RAM device. It manages to
trigger the issue relatively reliably (within 60 seconds) with munmap() =
and
slightly less reliably with MADV_DONTNEED. I have no idea if it works in =
VM,
deep C-states, etc..

-- >8 --

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
		ptr =3D mmap(p, PAGE_SIZE, PROT_READ|PROT_WRITE,
			   MAP_SHARED|MAP_FIXED|MAP_POPULATE, fd, 0);
		if (ptr =3D=3D MAP_FAILED)
			handle_error("remap_thread");
#else
		if (madvise(p, PAGE_SIZE, MADV_DONTNEED) < 0)
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
	};=09
	int r, i;
	int rc1, rc2;
	unsigned long addr;
	void *ptr;
	char *page =3D malloc(PAGE_SIZE);
	int n_threads =3D sizeof(thread_funcs) / sizeof(*thread_funcs);
	pthread_t *threads =3D malloc(sizeof(pthread_t) * n_threads);
	pid_t pid;
=09
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
=09
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
	printf("Finished without an error");

	exit(0);
}=
